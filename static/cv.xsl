<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="cv">
        <html lang="sv">
            <head>
                <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
                <meta name="viewport" content="width=device-width,initial-scale=1" />
                <title><xsl:value-of select="title"/></title>
                <link type="text/css" rel="stylesheet" href="style.css" />
            </head>
            <body>
                <div class="document">
                    <span class="top-title"><xsl:value-of select="header"/></span>
                    
                    <xsl:apply-templates select="section"/>
                    
                    <div class="footer">
                        <div class="footer-content">
                            <p class="meta">
                                CV - Joakim olsson
                            </p>
                            <p class="lastupdated meta">
                                <xsl:apply-templates select="lastupdated" />
                            </p>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!--
    Sections have their title element printed above them,
    and only applies a limited selection of templates.
    /-->
    <xsl:template match="section">
        <xsl:if test="not(@break-before)">
            <span class="title section-title">
                <xsl:value-of select="title" />
            </span>
        </xsl:if>
        <xsl:if test="@break-before">
            <span class="title section-title break-before">
                <xsl:value-of select="title" />
            </span>
        </xsl:if>
        <div>
            <xsl:attribute name="class">section <xsl:value-of select="@name"/></xsl:attribute>
            <xsl:apply-templates select="section | text | info | event | language | tech | date" />
        </div>
    </xsl:template>
    
    <!--
    Text areas try to apply templates to all descendants of the text element.
    /-->
    <xsl:template match="text">
        <div class="text">
            <xsl:apply-templates />
        </div>
    </xsl:template>
    
    <xsl:template match="heading">
        <span class="heading">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    
    <xsl:template match="p">
        <p>
            <xsl:apply-templates />
        </p>
    </xsl:template>
    
    <xsl:template match="link">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@href"/>
            </xsl:attribute>
            <xsl:apply-templates />
        </a>
    </xsl:template>
    
    <xsl:template match="info">
        <div class="info">
            <span class="item">
                <xsl:value-of select="item"/>
            </span>
            <span class="value">
                <xsl:choose>
                    <xsl:when test="@type='email'">
                        <a class="email">
                            <xsl:attribute name="href">
                                mailto:<xsl:value-of select="value" />
                            </xsl:attribute>
                            <xsl:value-of select="value" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="value"/>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </div>
    </xsl:template>
    
    <xsl:template match="event">
        <div class="event">
            <span class="title">
                <xsl:value-of select="title" />
            </span>
            <span class="date">
                <xsl:if test="date[@type='start']">
                    <xsl:apply-templates select="./date[@type='start']" />
                    -
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="date[@type='end']">
                        <xsl:apply-templates select="./date[@type='end']" />
                    </xsl:when>
                    <xsl:otherwise>
                        (Pågående)
                    </xsl:otherwise>
                </xsl:choose>
                
            </span>
            <div class="description">
                <xsl:apply-templates select="description" />
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="language">
        <div class="language">
            <xsl:value-of select="name"/>
        </div>
    </xsl:template>
    
    <xsl:template match="tech">
        <div class="tech">
            <xsl:value-of select="." />
        </div>
    </xsl:template>
    
    <xsl:template match="adress">
        <span class="adress">
            <span class="street"><xsl:value-of select="@street"/></span>&#160;<span class="number"><xsl:value-of select="@number"/></span>, 
            <span class="city"><xsl:value-of select="@city"/></span>
        </span>
    </xsl:template>
    
    <xsl:template match="date">
        <xsl:if test="@day">
            <xsl:value-of select="@day" /> 
        </xsl:if>
        <xsl:choose>
            <xsl:when test="@month='1'">
                Januari
            </xsl:when>
            <xsl:when test="@month='2'">
                Februari
            </xsl:when>
            <xsl:when test="@month='3'">
                Mars
            </xsl:when>
            <xsl:when test="@month='4'">
                April
            </xsl:when>
            <xsl:when test="@month='5'">
                Maj
            </xsl:when>
            <xsl:when test="@month='6'">
                Juni
            </xsl:when>
            <xsl:when test="@month='7'">
                Juli
            </xsl:when>
            <xsl:when test="@month='8'">
                Augusti
            </xsl:when>
            <xsl:when test="@month='9'">
                September
            </xsl:when>
            <xsl:when test="@month='10'">
                Oktober
            </xsl:when>
            <xsl:when test="@month='11'">
                November
            </xsl:when>
            <xsl:when test="@month='12'">
                December
            </xsl:when>
            <xsl:when test="@month">
                <xsl:value-of select="@month" />
            </xsl:when>
            <xsl:otherwise>
                
            </xsl:otherwise>
        </xsl:choose> 
        <xsl:value-of select="./@year" />
    </xsl:template>
</xsl:stylesheet>