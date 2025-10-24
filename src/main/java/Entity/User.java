package Entity;

import java.util.Date;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 255, unique = true)
    private String username;

    @Column(nullable = false, length = 50)
    private String password;

    @Column(length = 50)
    private String fullname;

    @Column(name = "DiaChi", nullable = false, length = 50)
    private String diaChi;

    @Column(name = "SDT", nullable = false, length = 50)
    private String sdt;

    @Column(name = "roleID")
    private Integer roleID;

    @Column(length = 50)
    private String email;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "reset_expiry")
    private Date resetExpiry;

    @Column(name = "reset_code", length = 10)
    private String resetCode;
}
