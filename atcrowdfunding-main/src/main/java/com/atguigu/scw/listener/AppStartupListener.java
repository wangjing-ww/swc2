package com.atguigu.scw.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
/**
 * 全局上下文对象的监听器
 */
public class AppStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        System.out.println("项目 启动 成功");
        //全局上下文对象创建后立即调用： 设置初始化参数
        servletContextEvent.getServletContext().setAttribute("PATH",
                servletContextEvent.getServletContext().getContextPath());
    }
    //全局上下文对象销毁前立即调用： 完成收尾操作[持久化参数值]
    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
