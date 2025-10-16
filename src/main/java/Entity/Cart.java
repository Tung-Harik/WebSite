package Entity;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Cart")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cart {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
	
	@Column(name = "created_at", columnDefinition = "datetime")
    private LocalDateTime createdAt;
	
	@Column(name = "is_checked_out", nullable = false)
    private Boolean checkedOut = false;
	
	@OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<CartItems> items = new ArrayList<>();

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) createdAt = LocalDateTime.now();
        if (checkedOut == null) checkedOut = false;
    }
}
