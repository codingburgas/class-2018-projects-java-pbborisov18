package utils;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class PasswordHasher {
	
	public static String passwordHasher(String password, byte[] salt) {
		
		KeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 65536, 128);
		
		SecretKeyFactory f;
		
		try {
			f = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
			byte[] hash = f.generateSecret(spec).getEncoded();
			Base64.Encoder enc = Base64.getEncoder();
			return enc.encodeToString(hash);
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("Hash unsuccessful!");
		return password;
	}
}
