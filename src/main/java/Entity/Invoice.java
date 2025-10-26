package Entity;

import java.math.BigDecimal;
import java.util.Date;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Invoices")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Invoice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MaHD")
    private int id;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "NgayLap", nullable = false)
    private Date ngayLap = new Date();

    @Column(name = "NguoiDungID", nullable = false)
    private int nguoiDungID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NguoiDungID", insertable = false, updatable = false)
    private User user;
    
    // Liên kết với Product
    @ManyToOne
    @JoinColumn(name = "SanPhamID", nullable = false)
    private Product product;

    @Column(name = "SoLuong", nullable = false)
    private int soLuong;

    @Column(name = "DonGia", precision = 18, scale = 2, nullable = false)
    private BigDecimal donGia;

    @Column(name = "TongTien", precision = 18, scale = 2, insertable = false, updatable = false)
    private BigDecimal tongTien;

    @Column(name = "GhiChu")
    private String ghiChu;
}
