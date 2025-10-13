package Entity;

import java.math.BigDecimal;
import java.util.Date;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "Invoices")
@Getter
@Setter
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

    // Liên kết với Product
    @ManyToOne
    @JoinColumn(name = "SanPhamID", nullable = false)
    private Product product;

    @Column(name = "SoLuong", nullable = false)
    private int soLuong;

    @Column(name = "DonGia", precision = 18, scale = 2, nullable = false)
    private BigDecimal donGia;

    // 👇 computed column: Hibernate chỉ đọc, không ghi
    @Column(name = "TongTien", precision = 18, scale = 2, insertable = false, updatable = false)
    private BigDecimal tongTien;

    @Column(name = "GhiChu")
    private String ghiChu;
}
