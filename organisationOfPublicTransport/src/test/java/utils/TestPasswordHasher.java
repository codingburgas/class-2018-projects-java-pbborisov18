package utils;

import static org.junit.Assert.assertEquals;

import java.nio.ByteBuffer;

import org.junit.Test;

public class TestPasswordHasher {
	byte[] s = ByteBuffer.allocate(6).putInt(321321).array();
	
	@Test
	public void testpasswordHasher(){
		assertEquals("Vbupmji0wXFea8mcrzYceg==", PasswordHasher.passwordHasher("123", s));
		assertEquals("HjQARfIqB+RJGlVOSjoQyQ==", PasswordHasher.passwordHasher("234", s));
		assertEquals("f1U5k8ouyGkHUElDQTnpTg==", PasswordHasher.passwordHasher("1fdgoijfdgjo", s));
	}
}
