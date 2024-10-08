package org.scoula.config;

import org.scoula.oauth.controller.OauthServerTypeConverter;
import org.scoula.oauth.controller.OauthServerTypeConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.Ordered;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.*;

@EnableWebMvc
@ComponentScan(basePackages = {
        "org.scoula.safety_inspection",
        "org.scoula.commonsense.controller",
        "org.scoula.dictionary.controller",
        "org.scoula.faq.controller",
        "org.scoula.map.controller",
        "org.scoula.chat.controller",
        "org.scoula.oauth.controller",
        "org.scoula.like.dictionary.controller",
        "org.scoula.prevention.controller",
        "org.scoula.report.controller",
        "org.scoula.like.report.controller"
})
// Spring MVC용 컴포넌트 등록을 위한 스캔 페키지
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
    // 임시 CORS 설정 (추후 이동)
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("http://localhost:5173")
                .allowCredentials(true)
                .allowedMethods("*")
                .allowedHeaders("*");
    }

    // Servlet 3.0 v알 업로드 사용 시 - MulipartResolver 빈 등록
    @Bean
    public MultipartResolver multipartResolver() {
        return new StandardServletMultipartResolver();
    }

    // OauthServerTypeConverter 등록
    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addConverter(new OauthServerTypeConverter());
    }
}
