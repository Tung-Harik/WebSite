package Entity;

import java.math.BigDecimal;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "Products")
@Getter
@Setter
public class Product {
    @Id
    private int id;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(nullable = false, precision = 18, scale = 2)
    private BigDecimal prices; // ✅ Đúng kiểu cho DECIMAL(18,2)
}
