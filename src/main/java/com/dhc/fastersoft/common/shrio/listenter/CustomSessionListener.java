package com.dhc.fastersoft.common.shrio.listenter;


import org.apache.shiro.session.Session;
import org.apache.shiro.session.SessionListener;

import com.dhc.fastersoft.common.shrio.session.ShiroSessionRepository;

/**
* @ClassName: CustomSessionListener
* @Description: shrio 回话监听
* @author zby
* @date 2017年9月29日 
* 
*/
public class CustomSessionListener implements SessionListener {

    private ShiroSessionRepository shiroSessionRepository;

    /**
     * 一个回话的生命周期开始
     */
    @Override
    public void onStart(Session session) {
        //TODO
        System.out.println("on start");
    }
    /**
     * 一个回话的生命周期结束
     */
    @Override
    public void onStop(Session session) {
        //TODO
        System.out.println("on stop");
    }

    @Override
    public void onExpiration(Session session) {
        shiroSessionRepository.deleteSession(session.getId());
    }

    public ShiroSessionRepository getShiroSessionRepository() {
        return shiroSessionRepository;
    }

    public void setShiroSessionRepository(ShiroSessionRepository shiroSessionRepository) {
        this.shiroSessionRepository = shiroSessionRepository;
    }

}

