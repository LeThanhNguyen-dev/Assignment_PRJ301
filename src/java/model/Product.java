    package model;

    import java.util.Objects;

    public class Product {

        private int id;
        private String name;
        private String description;
        private String image;
        private double price;
        private int categoryId; // Thêm thuộc tính category

        public Product() {
        }

        public Product(int id, String name, String description, String image, double price, int categoryId) {
            this.id = id;
            this.name = name;
            this.description = description;
            this.image = image;
            this.price = price;
            this.categoryId = categoryId; // Khởi tạo category
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public String getImage() {
            return image;
        }

        public void setImage(String image) {
            this.image = image;
        }

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
        }

        public int getCategoryId() {
            return categoryId;
        }

        public void setCategoryId(int categoryId) {
            this.categoryId = categoryId;
        }

        @Override
        public String toString() {
            return "Product{"
                    + "id=" + id
                    + ", name='" + name + '\''
                    + ", description='" + description + '\''
                    + ", image='" + image + '\''
                    + ", price=" + price
                    + ", category='" + categoryId + '\''
                    + '}';
        }

        @Override
        public int hashCode() {
            return Objects.hash(id);
        }

        @Override
        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null || getClass() != obj.getClass()) {
                return false;
            }
            Product other = (Product) obj;
            return this.id == other.id; // So sánh chỉ theo ID, tránh lỗi HashMap
        }
    }
