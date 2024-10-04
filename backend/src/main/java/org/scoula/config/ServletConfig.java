package org.scoula.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.Ordered;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@EnableWebMvc
@ComponentScan(basePackages = {
        "org.scoula",
})    // Spring MVC용 컴포넌트 등록을 위한 스캔 페키지
public class ServletConfig implements WebMvcConfigurer {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/")
                .setViewName("forward:/resources/index.html");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**")    // url이 /resources/로 시작하는 모든 경로
                .addResourceLocations("/resources/");               // webapp/resources/경로로 매핑
        registry.addResourceHandler("/assets/**")       // Vue에서 사용 경로
                .addResourceLocations("/resources/assets/");        // 서버 경로
    }

    // jsp view resolver 설정
//    @Override
//    public void configureViewResolvers(ViewResolverRegistry registry) {
//        InternalResourceViewResolver bean = new InternalResourceViewResolver();
//
//        bean.setViewClass(JstlView.class);
//        bean.setPrefix("/WEB-INF/views/");
//        bean.setSuffix(".jsp");
//
//        registry.viewResolver(bean);
//    }

    // Servlet 3.0 v알 업로드 사용 시 - MulipartResolver 빈 등록
    @Bean
    public MultipartResolver multipartResolver() {
        return new StandardServletMultipartResolver();
    }
}
