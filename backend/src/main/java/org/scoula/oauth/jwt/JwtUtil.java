package org.scoula.oauth.jwt;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.scoula.oauth.domain.vo.Role;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

@Component
@PropertySource("classpath:application.properties")
/*
 * JWT 토큰을 생성하고 검증하는 유틸리티 클래스
 */
public class JwtUtil {

    @Value("${jwt.secret}")
    private String secretKey; // 시크릿 키

    @Value("${jwt.expired}")
    private long expirationTime; // 1일 (밀리초)

    public String generateToken(String userId, Role role) {
        // JWT 생성
        return Jwts.builder()
                .setSubject(userId)
                .claim("role", role.name())
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(secretKey.getBytes()).parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public String getUserIdFromToken(String token) {
        Claims claims = Jwts.parser().setSigningKey(secretKey.getBytes()).parseClaimsJws(token).getBody();
        return claims.getSubject();
    }
}
