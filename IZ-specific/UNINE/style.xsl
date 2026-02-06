<?xml version="1.0" encoding="utf-8"?>
<!-- IZ Customization: changed style of tables, smaller font sizes, and border sizes, adapted colors

    05/2022 - adapted generalStyle, added bodyStyleCss_transit,
    05/2022 - adapted mainTableStyleCss, headerTableStyleCss, footerTableStyleCss

-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="generalStyle">
 <style>
 body {@@language_related_body_css@@ background-color:#fff}
 h4{line-height: 0.12em}
 </style>
</xsl:template>

<xsl:template name="bodyStyleCss">
font-family: arial; color:#333; margin:0; padding:0em; font-size:80% 
</xsl:template>

<xsl:template name="bodyStyleCss_transit">
font-family: arial; color:#333; margin:0; padding:0em; font-size: 10%
</xsl:template>

<xsl:template name="listStyleCss">
list-style: none; margin:0 0 0 1em; padding:0
</xsl:template>

<xsl:template name="mainTableStyleCss">
width:100%; text-align:left
</xsl:template>

<xsl:template name="headerLogoStyleCss">
background-color:#ffffff;  width:100%;
</xsl:template>

<xsl:template name="headerTableStyleCss">
background-color:#0000aa;  width:100%; height:30px; color:#fff;
</xsl:template>

<xsl:template name="footerTableStyleCss">
background-color:#0000aa; width:100%; color:#fff; margin-top:1em;  font-weight:700; line-height:2em; font-size:150%;
</xsl:template>


</xsl:stylesheet>