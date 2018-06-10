package com.sports.cricket.model;

import java.io.Serializable;

public class Restrictions implements Serializable {

    private static final long serialVersionUID = 7516492295622776147L;

    private String securityCode;

    private Integer maxLimit;

    public String getSecurityCode() {
        return securityCode;
    }

    public void setSecurityCode(String securityCode) {
        this.securityCode = securityCode;
    }

    public Integer getMaxLimit() {
        return maxLimit;
    }

    public void setMaxLimit(Integer maxLimit) {
        this.maxLimit = maxLimit;
    }
}
