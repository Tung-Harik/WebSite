package Entity;

import java.math.BigDecimal;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.util.Date;

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

    @ManyToOne
    @JoinColumn(name = "SanPhamID", nullable = false)
    private Product product;

    @Column(name = "SoLuong", nullable = false)
    private int soLuong;

    @Column(name = "DonGia", precision = 18, scale = 2)
    private BigDecimal donGia;

    @Column(name = "TongTien", precision = 18, scale = 2)
    private BigDecimal tongTien;

    @Column(name = "GhiChu")
    private String ghiChu;
}
