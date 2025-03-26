package controller;

import dao.CartDAO;
import dao.ProductDAO;
import dao.VoucherDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Product;
import model.ProductSales;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Customer;

@WebServlet(urlPatterns = "/chat")
public class GeminiServlet extends HttpServlet {

    private static final String API_KEY = "AIzaSyAHwN0qrYCMxgipZR1sdA0qmlKsQSQqvT4";
    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + API_KEY;
    private ProductDAO productDAO;
    private VoucherDAO voucherDAO;
    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
        voucherDAO = new VoucherDAO();
        cartDAO = new CartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String prompt = request.getParameter("prompt");
        String customerIdStr = request.getParameter("customerId"); // Lấy customerId từ request

        // Debug: Kiểm tra customerId từ request
        System.out.println("Customer ID from request: " + customerIdStr);

        // Nếu customerId từ request tồn tại, lưu vào session
        if (customerIdStr != null && !customerIdStr.isEmpty()) {
            try {
                int customerId = Integer.parseInt(customerIdStr);
                session.setAttribute("customerId", customerId);
            } catch (NumberFormatException e) {
                System.err.println("Invalid customerId: " + customerIdStr);
            }
        }

        // Lấy customerId từ session
        Integer customerId = (Integer) session.getAttribute("customerId");
        System.out.println("Customer ID from session in doGet: " + customerId); // Debug

        List<String[]> chatHistory = (List<String[]>) session.getAttribute("chatHistory");
        if (chatHistory == null) {
            chatHistory = new ArrayList<>();
            session.setAttribute("chatHistory", chatHistory);
        }

        String textContent;
        if (prompt == null || prompt.trim().isEmpty()) {
            textContent = "Chào mừng bạn tới với Perfume Shop của chúng tôi!";
        } else {
            textContent = processPrompt(prompt, session);
            chatHistory.add(new String[]{"user", prompt});
            chatHistory.add(new String[]{"bot", textContent});
        }

        session.setAttribute("chatHistory", chatHistory);

        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().write(textContent);
    }

    private String processPrompt(String prompt, HttpSession session) throws IOException {
        String lowerPrompt = prompt.toLowerCase();
        System.out.println("Processing prompt: " + prompt); // Debug

        // Lấy customerId từ session
        Integer customerId = (Integer) session.getAttribute("customerId");
        System.out.println("Customer ID in processPrompt: " + customerId); // Debug

        // 1. Kiểm tra yêu cầu thêm sản phẩm vào giỏ hàng
        if (lowerPrompt.contains("tôi muốn thêm sản phẩm") && lowerPrompt.contains("vào giỏ hàng")) {
            String productName = extractProductNameFromAddRequest(lowerPrompt);
            if (productName != null && !productName.isEmpty()) {
                if (customerId == null) {
                    return "Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!";
                }

                // Tìm sản phẩm theo tên
                List<Product> products = productDAO.getProductsByQuery(productName);
                if (products.isEmpty()) {
                    return "Không tìm thấy sản phẩm '" + productName + "' trong hệ thống.";
                }

                // Giả định lấy sản phẩm đầu tiên nếu có nhiều kết quả
                Product product = products.get(0);
                CartItem cartItem = new CartItem(customerId, product.getId(), 1); // Số lượng mặc định là 1

                // Thêm vào giỏ hàng
                boolean success = cartDAO.insertCartItem(cartItem);
                if (success) {
                    Customer cus = (Customer) session.getAttribute("session_Login");
                    cus.updateCart();
                    return "Đã thêm sản phẩm '" + product.getName() + "' vào giỏ hàng của bạn!";
                } else {
                    return "Có lỗi xảy ra khi thêm sản phẩm '" + productName + "' vào giỏ hàng.";
                }
            }
            return "Vui lòng cung cấp tên sản phẩm hợp lệ (ví dụ: 'tôi muốn thêm sản phẩm Dior Sauvage vào giỏ hàng').";
        }

        // 2. Kiểm tra câu hỏi về ngày giờ
        if (isDateTimeQuestion(lowerPrompt)) {
            LocalDate today = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            return "Hôm nay là ngày " + today.format(formatter) + ".";
        }

        // 3. Kiểm tra voucher/khuyến mãi
        if (lowerPrompt.contains("voucher") || lowerPrompt.contains("mã giảm giá")
                || lowerPrompt.contains("khuyến mãi") || lowerPrompt.contains("ưu đãi")) {
            try {
                List<model.Voucher> vouchers = voucherDAO.getAllVouchers();
                if (vouchers.isEmpty()) {
                    return "Hiện tại không có voucher hay ưu đãi nào khả dụng.";
                }
                StringBuilder voucherInfo = new StringBuilder("Danh sách voucher/ưu đãi hiện tại:\n");
                for (model.Voucher v : vouchers) {
                    voucherInfo.append(String.format("- Mã: %s, Giảm: %.2f%%, Hết hạn: %s\n",
                            v.getCode(), v.getDiscount(), v.getExpiryDate()));
                }
                return voucherInfo.toString();
            } catch (Exception e) {
                return "Lỗi khi lấy thông tin voucher: " + e.getMessage();
            }
        }

        // 4. Kiểm tra câu hỏi về giá sản phẩm
        if (lowerPrompt.contains("giá") || lowerPrompt.contains("bao nhiêu")
                || lowerPrompt.contains("trị giá") || lowerPrompt.contains("chi phí")
                || lowerPrompt.contains("đắt") || lowerPrompt.contains("rẻ")) {
            String productName = extractProductName(lowerPrompt);
            if (productName != null && !productName.isEmpty()) {
                List<Product> products = productDAO.getProductsByQuery(productName);
                if (products.isEmpty()) {
                    return "Không tìm thấy sản phẩm '" + productName + "' trong hệ thống.";
                }
                StringBuilder priceInfo = new StringBuilder();
                for (Product p : products) {
                    priceInfo.append(String.format("Sản phẩm: %s - Giá: %.2f $\n",
                            p.getName(), p.getPrice()));
                }
                return priceInfo.toString();
            }

            // Kiểm tra giá cao nhất
            if (lowerPrompt.contains("cao nhất") || lowerPrompt.contains("đắt nhất")
                    || lowerPrompt.contains("giá lớn nhất")) {
                Product highestPricedProduct = productDAO.getHighestPricedProduct();
                if (highestPricedProduct != null) {
                    return String.format("Sản phẩm giá cao nhất: %s - Giá: %.2f $",
                            highestPricedProduct.getName(), highestPricedProduct.getPrice());
                }
                return "Không tìm thấy sản phẩm giá cao nhất.";
            }

            // Kiểm tra giá thấp nhất
            if (lowerPrompt.contains("thấp nhất") || lowerPrompt.contains("rẻ nhất")
                    || lowerPrompt.contains("giá nhỏ nhất")) {
                Product lowestPricedProduct = productDAO.getLowestPricedProduct();
                if (lowestPricedProduct != null) {
                    return String.format("Sản phẩm giá thấp nhất: %s - Giá: %.2f $",
                            lowestPricedProduct.getName(), lowestPricedProduct.getPrice());
                }
                return "Không tìm thấy sản phẩm giá thấp nhất.";
            }

            return "Vui lòng cung cấp tên sản phẩm hoặc hỏi cụ thể hơn (ví dụ: 'X giá bao nhiêu?').";
        }

        // 5. Kiểm tra top sản phẩm bán chạy
        if (lowerPrompt.contains("top") || lowerPrompt.contains("bán chạy")
                || lowerPrompt.contains("nổi bật") || lowerPrompt.contains("phổ biến")) {
            try {
                List<ProductSales> topProducts = productDAO.getTop3BestSellingProducts();
                if (topProducts.isEmpty()) {
                    return "Hiện tại không có dữ liệu về sản phẩm bán chạy.";
                }
                StringBuilder topInfo = new StringBuilder("Top 3 sản phẩm bán chạy nhất:\n");
                int totalQuantity = 0;
                for (int i = 0; i < topProducts.size(); i++) {
                    ProductSales ps = topProducts.get(i);
                    totalQuantity += ps.getTotalQuantity();
                    topInfo.append(String.format("%d. %s (%s) - Số lượng bán: %d\n",
                            i + 1, ps.getProductName(), ps.getCategoryName(), ps.getTotalQuantity()));
                }
                topInfo.append(String.format("Tổng số lượng bán của top 3: %d", totalQuantity));
                return topInfo.toString();
            } catch (Exception e) {
                return "Lỗi khi lấy danh sách sản phẩm bán chạy: " + e.getMessage();
            }
        }

        // 6. Gọi Gemini API nếu không khớp điều kiện nào
        String apiResult = callGeminiAPI(prompt);
        return extractTextFromJson(apiResult);
    }

    // Trích xuất tên sản phẩm từ yêu cầu thêm vào giỏ hàng
    private String extractProductNameFromAddRequest(String prompt) {
        String prefix = "tôi muốn thêm sản phẩm";
        String suffix = "vào giỏ hàng";
        int startIndex = prompt.toLowerCase().indexOf(prefix) + prefix.length();
        int endIndex = prompt.toLowerCase().indexOf(suffix);

        if (startIndex >= prefix.length() && endIndex > startIndex) {
            return prompt.substring(startIndex, endIndex).trim();
        }
        return null;
    }

    // Cải thiện phương thức trích xuất tên sản phẩm (dùng cho câu hỏi về giá)
    private String extractProductName(String prompt) {
        String[] words = prompt.split("\\s+");
        StringBuilder productName = new StringBuilder();
        List<String> stopWords = List.of("giá", "bao nhiêu", "trị giá", "chi phí", "của",
                "cao nhất", "thấp nhất", "đắt nhất", "rẻ nhất",
                "là", "thế nào", "ra sao");

        for (String word : words) {
            if (stopWords.contains(word)) {
                break; // Dừng khi gặp từ khóa kết thúc
            }
            if (productName.length() > 0) {
                productName.append(" ");
            }
            productName.append(word);
        }

        return productName.length() > 0 ? productName.toString().trim() : null;
    }

    // Kiểm tra câu hỏi về ngày giờ
    private boolean isDateTimeQuestion(String prompt) {
        return (prompt.contains("hôm nay") || prompt.contains("ngày nay") || prompt.contains("hiện tại"))
                && (prompt.contains("ngày bao nhiêu") || prompt.contains("ngày mấy") || prompt.contains("ngày nào"));
    }

    private String callGeminiAPI(String prompt) throws IOException {
        URL url = new URL(API_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        String jsonInputString = "{\"contents\": [{\"parts\": [{\"text\": \"" + prompt + "\"}]}]}";
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonInputString.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"))) {
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }
        } catch (IOException e) {
            return "Lỗi khi gọi API: " + e.getMessage();
        } finally {
            conn.disconnect();
        }
        return response.toString();
    }

    private String extractTextFromJson(String jsonResponse) {
        try {
            JSONObject responseJson = new JSONObject(jsonResponse);
            JSONArray candidates = responseJson.getJSONArray("candidates");
            JSONObject candidate = candidates.getJSONObject(0);
            JSONObject content = candidate.getJSONObject("content");
            JSONArray parts = content.getJSONArray("parts");
            return parts.getJSONObject(0).getString("text");
        } catch (Exception e) {
            return "Lỗi phân tích JSON: " + e.getMessage();
        }
    }

    @Override
    public void destroy() {
        if (productDAO != null) {
            productDAO.closeConnection();
        }
        if (voucherDAO != null) {
            voucherDAO.closeConnection();
        }
        if (cartDAO != null) {
            cartDAO.closeConnection();
        }
    }
}
