package test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

public class test {
    public static void main(String[] args)
    {
        ApplicationContext ac = new FileSystemXmlApplicationContext("applicationContext.xml");
        TestService ts = (TestService)ac.getBean("testService");
        ts.hello();
    }

}
