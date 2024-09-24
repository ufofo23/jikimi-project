package org.scoula.config;

import org.springframework.security.access.SecurityConfig;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer
{
//    final String LOCATION = "c:/upload";
//    final long MAX_FILE_SIZE = 10L * 1024 * 1024;      // 1개
//    final long MAX_REQUEST_SIZE = 20L * 1024 * 1024;   // 전체
//    final int FILE_SIZE_THRESHOLD = 5 * 1024 * 1024;   // 임시파일 5메가 미만 메모리 직접처리

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[] { RootConfig.class };
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[] { ServletConfig.class };
    }

    // 스프링의 FrontController인 DispatcherServlet이 담당할 Url 매핑 패턴, / : 모든 요청에 대해 매핑
    @Override
    protected String[] getServletMappings() {
        return new String[] { "/" };
    }

    // POST body 문자 인코딩 필터 설정 - UTF-8 설정
//    @Override
//    protected Filter[] getServletFilters() {
//        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
//
//        characterEncodingFilter.setEncoding("UTF-8");
//        characterEncodingFilter.setForceEncoding(true);
//
//        return new Filter[] { characterEncodingFilter };
//    }

//    @Override
//    protected void customizeRegistration(ServletRegistration.Dynamic registration) {
//        registration.setInitParameter("throwExceptionIfNoHandlerFound", "true");
//        MultipartConfigElement multipartConfig = new MultipartConfigElement(
//                LOCATION,             // 업로드 디렉토리 경로
//                MAX_FILE_SIZE,        // 업로드 가능한 파일 하나의 최대 크기
//                MAX_REQUEST_SIZE,     // 업로드 가능한 전체 최대 크기(여러 파일 업로드 하는 경우)
//                FILE_SIZE_THRESHOLD   // 메모리 파일의 최대 크기(이보다 작으면 실제 메모리에서만 작업)
//        );
//        registration.setMultipartConfig(multipartConfig);
//    }
}
