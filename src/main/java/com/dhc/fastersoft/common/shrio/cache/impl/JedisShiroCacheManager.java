package com.dhc.fastersoft.common.shrio.cache.impl;

import org.apache.shiro.cache.Cache;

import com.dhc.fastersoft.common.shrio.cache.JedisManager;
import com.dhc.fastersoft.common.shrio.cache.JedisShiroCache;
import com.dhc.fastersoft.common.shrio.cache.ShiroCacheManager;


/**
* @ClassName: JedisShiroCacheManager
* @Description: Jedis管理
* @author zby
* @date 2017年9月29日 
* 
*/
public class JedisShiroCacheManager implements ShiroCacheManager {

    private JedisManager jedisManager;

    @Override
    public <K, V> Cache<K, V> getCache(String name) {
        return new JedisShiroCache<K, V>(name, getJedisManager());
    }

    @Override
    public void destroy() {
    	//如果和其他系统，或者应用在一起就不能关闭
    	//getJedisManager().getJedis().shutdown();
    }

    public JedisManager getJedisManager() {
        return jedisManager;
    }

    public void setJedisManager(JedisManager jedisManager) {
        this.jedisManager = jedisManager;
    }
}
