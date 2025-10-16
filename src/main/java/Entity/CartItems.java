package Entity;

import java.math.BigDecimal;
import java.math.RoundingMode;

import jakarta.persistence.*;
import lombok.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "CartItems")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItems {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cart_id", nullable = false)
    private Cart cart;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;
	
	@NotNull
    @Min(1)
    @Column(nullable = false)
    private Integer quantity;
	
	@NotNull
    @Column(nullable = false, precision = 18, scale = 2)
    private BigDecimal price;
	
	@Transient
    public BigDecimal getSubtotal() {
        if (price == null || quantity == null) return BigDecimal.ZERO;
        return price.multiply(BigDecimal.valueOf(quantity)).setScale(2, RoundingMode.HALF_UP);
    }
}
