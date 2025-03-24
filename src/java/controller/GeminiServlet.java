package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import dao.ProductDAO;
import dao.VoucherDAO;
import model.Product;
import model.ProductSales;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(urlPatterns = "/chat")
public class GeminiServlet extends HttpServlet {
    private static final String API_KEY = "AIzaSyAHwN0qrYCMxgipZR1sdA0qmlKsQSQqvT4";
    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + API_KEY;
    private ProductDAO productDAO;
    private VoucherDAO voucherDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
        voucherDAO = new VoucherDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String prompt = request.getParameter("prompt");

        List<String[]> chatHistory = (List<String[]>) session.getAttribute("chatHistory");
        if (chatHistory == null) {
            chatHistory = new ArrayList<>();
            session.setAttribute("chatHistory", chatHistory);
        }

        String textContent;
        if (prompt == null || prompt.trim().isEmpty()) {
            textContent = "Chào mừng bạn tới với Perfume Shop của chúng tôi!";
        } else {
            textContent = processPrompt(prompt);
            chatHistory.add(new String[]{"user", prompt});
            chatHistory.add(new String[]{"bot", textContent});
        }

        session.setAttribute("chatHistory", chatHistory);

        // Trả về phản hồi dạng text thay vì forward
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().write(textContent);
    }

    private String processPrompt(String prompt) throws IOException {
    String lowerPrompt = prompt.toLowerCase();

    if (isDateTimeQuestion(lowerPrompt)) {
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return "Hôm nay là ngày " + today.format(formatter) + ".";
    }

    if (lowerPrompt.contains("voucher") || lowerPrompt.contains("mã giảm giá")) {
        try {
            List<model.Voucher> vouchers = voucherDAO.getAllVouchers();
            if (vouchers.isEmpty()) {
                return "Hiện tại không có voucher nào khả dụng.";
            }
            StringBuilder voucherInfo = new StringBuilder("Danh sách voucher hiện tại:\n");
            for (model.Voucher v : vouchers) {
                voucherInfo.append(String.format("- Mã: %s, Giảm: %.2f%%, Hết hạn: %s\n",
                    v.getCode(), v.getDiscount(), v.getExpiryDate()));
            }
            return voucherInfo.toString();
        } catch (Exception e) {
            return "Lỗi khi lấy thông tin voucher: " + e.getMessage();
        }
    }

    if (lowerPrompt.contains("giá") || lowerPrompt.contains("bao nhiêu")) {
        String productName = extractProductName(lowerPrompt);
        System.out.println("Extracted product name: " + productName); // Debug
        if (productName != null) {
            List<Product> products = productDAO.getProductsByQuery(productName);
            System.out.println("Found products: " + products.size()); // Debug
            if (products.isEmpty()) {
                return "Không tìm thấy sản phẩm '" + productName + "' trong database.";
            }
            StringBuilder priceInfo = new StringBuilder();
            for (Product p : products) {
                priceInfo.append(String.format("Sản phẩm: %s - Giá: %.2f VNĐ\n", 
                    p.getName(), p.getPrice()));
            }
            return priceInfo.toString();
        } else {
            return "Không thể xác định tên sản phẩm từ câu hỏi của bạn.";
        }
    }

    if (lowerPrompt.contains("top") && lowerPrompt.contains("bán chạy")) {
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
            return "Lỗi khi lấy top sản phẩm: " + e.getMessage();
        }
    }

    String apiResult = callGeminiAPI(prompt);
    return extractTextFromJson(apiResult);
}

    private String extractProductName(String prompt) {
    String[] words = prompt.split("\\s+");
    StringBuilder productName = new StringBuilder();
    boolean foundKeyword = false;

    for (int i = 0; i < words.length; i++) {
        if (words[i].equals("giá") || words[i].equals("bao nhiêu")) {
            foundKeyword = true;
            break;
        }
        if (i > 0 && words[i - 1].equals("của")) {
            continue; // Bỏ qua từ "của"
        }
        if (productName.length() > 0) {
            productName.append(" ");
        }
        productName.append(words[i]);
    }

    return foundKeyword && productName.length() > 0 ? productName.toString() : null;
}

    private boolean isDateTimeQuestion(String prompt) {
        return prompt.contains("hôm nay") && 
               (prompt.contains("ngày bao nhiêu") || prompt.contains("ngày mấy"));
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
        if (productDAO != null) productDAO.closeConnection();
        if (voucherDAO != null) voucherDAO.closeConnection();
    }
}