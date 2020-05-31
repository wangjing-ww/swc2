package com.atguigu.scw.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


//在Spring中，表示基本组件的是Component，业务层组件Service，持久化层组件repository,表述层的组件controller
//表示配置类组件Configuration
@EnableWebSecurity //启用security的web功能
@EnableGlobalMethodSecurity(prePostEnabled = true)//启用springsecurity通过controller映射进行权限认证的功能
@Configuration
public class AppSpringSecurityConfig extends WebSecurityConfigurerAdapter {

    //授权
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        //1、授权首页+静态资源+登录页面 任何人都可以访问
        http.authorizeRequests()
                //permitAll() 所有人都可以访问
                .antMatchers("/" , "/index","/static/**" , "/login.html")
                .permitAll() //配置浏览器访问首页的地址
                //hasAnyRole( 授权角色 才可以访问
                //hasAnyAuthority()授权指定权限 才可以访问
                .antMatchers("/admin/index").hasAnyRole("ADMIN")
                .anyRequest().authenticated();//配置其他的任意请求都需要授权认证
                //authenticated()  只有登入成功 才可以访问
         // 2 使用SpringSecurity接管登入
          //springSecurity需要在登录时为登录用户创建主体(账号信息+权限角色信息)
        http.formLogin()
                  //登入得页面
                .loginPage("/login.html")
                // 指定登入得url
                .loginProcessingUrl("/admin/login")
                .usernameParameter("loginacct")
                .passwordParameter("userpswd")
                .defaultSuccessUrl("/admin/main.html");
        //由于没有配置springsecurity如何验证登录账号密码正确性，
        // 所以默认认证账号都会登录失败
        //取消 跨站点攻击
        //SpringSecurity 认为提交表单 会攻击 默认 加上csrf
        //http.csrf().disable();

        //3SpringSecurity 认证注销功能
        http.logout()
                .logoutUrl("/admin/logout")
                .logoutSuccessUrl("/index");

        //异常 处理页面
        http.exceptionHandling().accessDeniedHandler(new AccessDeniedHandler() {
            @Override
            public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
                //处理403
                //判断 同步还是 异步
                //异步请求报文请求头里面 有参数：X-Requested-With: XMLHttpRequest
                if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))){
                    // 异步请求 不需要整个页面 只需要相应的状态
                    response.getWriter().write("fail");
                }else {
                    String message = accessDeniedException.getMessage();
                    request.setAttribute("errorMsg", message);
                    request.getRequestDispatcher("/WEB-INF/pages/error/403.jsp").forward(request, response);
                }
            }
        });


    }

    @Autowired
    UserDetailsService userDetailsService;

    @Autowired
    PasswordEncoder passwordEncoder;
    //认证:创建 主体（账号密码+角色权限）
    // 如果提供了主体创建得业务代码 登入时报错 则提示badcredentials
    //如果没有提供主体创建的业务代码，登录报错没有处理登录请求的认证提供者
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
       //自己写的代码 创建主体

      /*  auth.inMemoryAuthentication()
                .withUser("admin").password("123456")
                //authorities 添加 权限
                //roles  给内存行号添加角色列表
                // 底层调用authorities来实现
                //但是 会在roles方法中 传入得每一个参数前拼接 "ROLE_"
                .authorities("user:add","menu:del")
                .and()
                .withUser("nini").password("123456")
                .roles("ADMIN","BOSS");
        //      authorities("ROLE_ADMIN")*/

        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
    }
}
