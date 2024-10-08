package org.scoula.safety_inspection.codef;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * <pre>
 * io.codef.easycodef
 *   |  EasyCodefClientInfo.java
 * </pre>
 *
 * Desc : EasyCodef 발급 클라이언트 정보 설정 클래스
 * @Company : ©CODEF corp.
 * @Author  : notfound404@codef.io
 * @Date    : Jun 26, 2020 3:42:11 PM
 * @Version : 1.0.1
 */

@Component
@Getter
public class EasyCodefClientInfo {

	/**
	 * TODO :	사용자는 코드에프 가입을 통해 발급 받은 클라이언트 정보와 RSA 공개키 정보를 설정해야 함.
	 * 			설정하지 않은 상태에서는 SANDBOX 테스트만 사용 가능.
	 */

	@Value("${easycodef.demo.client.id}")
	private String demoClientId;

	@Value("${easycodef.demo.client.secret}")
	private String demoClientSecret;

	@Value("${easycodef.client.id}")
	private String clientId;

	@Value("${easycodef.client.secret}")
	private String clientSecret;

	@Value("${easycodef.public.key}")
	private String publicKey;

	public static String DEMO_CLIENT_ID;
	public static String DEMO_CLIENT_SECRET;
	public static String CLIENT_ID;
	public static String CLIENT_SECRET;
	public static String PUBLIC_KEY;

	public EasyCodefClientInfo(
			@Value("${easycodef.demo.client.id}") String demoClientId,
			@Value("${easycodef.demo.client.secret}") String demoClientSecret,
			@Value("${easycodef.client.id}") String clientId,
			@Value("${easycodef.client.secret}") String clientSecret,
			@Value("${easycodef.public.key}") String publicKey) {

		EasyCodefClientInfo.DEMO_CLIENT_ID = demoClientId;
		EasyCodefClientInfo.DEMO_CLIENT_SECRET = demoClientSecret;
		EasyCodefClientInfo.CLIENT_ID = clientId;
		EasyCodefClientInfo.CLIENT_SECRET = clientSecret;
		EasyCodefClientInfo.PUBLIC_KEY = publicKey;
	}
}
