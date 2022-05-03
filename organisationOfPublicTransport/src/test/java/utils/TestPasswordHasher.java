package utils;


import static org.assertj.core.api.Assertions.assertThat;

import java.nio.ByteBuffer;

import org.junit.jupiter.api.Test;


public class TestPasswordHasher {
	
	
	@Test	
	void testpasswordHasher(){ 
		byte[] salt = ByteBuffer.allocate(6).putInt(321321).array();
		
		assertThat(PasswordHasher.passwordHasher("123", salt)).isEqualTo("Vbupmji0wXFea8mcrzYceg==");
		assertThat(PasswordHasher.passwordHasher("234", salt)).isEqualTo("HjQARfIqB+RJGlVOSjoQyQ==");
		assertThat(PasswordHasher.passwordHasher("1fdgoijfdgjo", salt)).isEqualTo("f1U5k8ouyGkHUElDQTnpTg==");
	}
}
