package Entity;

import java.math.BigDecimal;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Products")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(nullable = false, precision = 18, scale = 2)
    private BigDecimal prices; //Đúng kiểu cho DECIMAL(18,2)
    
    @OneToMany(mappedBy = "product")
    private List<Invoice> invoices;
}
