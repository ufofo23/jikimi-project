package org.scoula.codefapi.codef;

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
public class EasyCodefClientInfo {

	/**	
	 * TODO :	사용자는 코드에프 가입을 통해 발급 받은 클라이언트 정보와 RSA 공개키 정보를 설정해야 함.
	 * 			설정하지 않은 상태에서는 SANDBOX 테스트만 사용 가능.
	 */
	public static final String DEMO_CLIENT_ID = "37ea749b-17a0-4d0a-a4cf-5b49e6cfd011";
	public static final String DEMO_CLIENT_SECRET = "51571c12-b809-4758-b915-97687bdf8207";
	
	public static final String CLIENT_ID = "코드에프 데모 서비스 신청 후 발급 받은 정식버전 클라이언트 아이디 설정";
	public static final String CLIENT_SECRET = "코드에프 데모 서비스 신청 후 발급 받은 정식버전 클라이언트 아이디 설정";
	
	/**  임시로 설정된 PUBLIC_KEY를 제거하고 코드에프 가입을 통해 발급 받은 본인 계정의 RSA 공개키 정보 설정 필요. */
	public static final String PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvGJhD8SXaBSZMbAabHFZbMCFSc00IGdqvFv1Xsf+cIZIVsLRC9dseBVntHaUcQ9YS4aZ5vHpB5jeOtHful25jmeThm483fC5jX/1dc6O8dliecMNZBnQh++G4xfNSxJiprvFZ9JeSJe13l2yNhsR6Io2qH34037SNw0YUhEfolmxYBVRQw8fzwXJbeODs+WH1WYHpYD94qmXDzQcU+TOn8rA+PAEGkEnOABN5FTw9UxI8ebX11TmaD+exE/TIl4g5Jum4KZg7jITNVh0u7HSdTPPrZ4yntFxjcZulMATBR5SPyY7WktehCeG1grekvkoEmTsrX9OGXAwXV6+ODomiQIDAQAB";
	
}
