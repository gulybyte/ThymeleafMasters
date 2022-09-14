package com.devthymeleaf.springbootmvcthymeleaf.security.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class GeradorSenha {

    public static void main(String[]args){
        for(int y=0;y<10;y++){
            BCryptPasswordEncoder x=new BCryptPasswordEncoder();
            String s="senhaaqui",
                    t=x.encode(s),r="Criptografia ",p=" = '",o="';",c=r+y+p+t+o;
            System.out.println(c);
        }
    }

}
