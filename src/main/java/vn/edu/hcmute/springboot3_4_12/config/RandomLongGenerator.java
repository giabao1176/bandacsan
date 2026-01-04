package vn.edu.hcmute.springboot3_4_12.config;

import org.hibernate.engine.spi.SharedSessionContractImplementor;
import org.hibernate.id.IdentifierGenerator;

import java.security.SecureRandom;
public class RandomLongGenerator implements IdentifierGenerator {
    private final SecureRandom random = new SecureRandom();

    @Override
    public Object generate(SharedSessionContractImplementor session, Object object) {
        // Tạo số long dương ngẫu nhiên
        return random.nextLong(Long.MAX_VALUE);
    }
}