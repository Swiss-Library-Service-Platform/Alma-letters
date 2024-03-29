<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="generalStyle">
 <style>
 body {background-color:#fff; font-family: Arial, Helvetica, sans-serif}
 .listing td {border-bottom: 1px solid #eee}
 .listing tr:hover td {background-color:#eee}
 .listing th {background-color:#f5f5f5 }
h4 {line-height: 0.2em;margin: 0;}
 </style>
</xsl:template>

<xsl:template name="bodyStyleCss">
font-family: Arial; color:#333; margin:0; padding:0em; font-size:80% 
</xsl:template>

<xsl:template name="listStyleCss">
list-style: none; margin:0 0 0 0em; padding:0 <!-- was: margin:0 0 0 1em -->
</xsl:template>

<xsl:template name="mainTableStyleCss">
width:100%; text-align:left
</xsl:template>

<xsl:template name="headerLogoStyleCss">
background-color:#ffffff;  width:100%;
</xsl:template>

<xsl:template name="headerTableStyleCss">
background-color:#e9e9e9;  width:50%; height:30px; text-shadow:1px 1px 1px #fff; margin-bottom: 2cm; margin-top: 5em; <!--change width from 100 to 50; added margin-top for direct printing-->
</xsl:template>

<xsl:template name="footerTableStyleCss">
background-color:#e9e9e9;  width:100%; <!-- text-shadow:1px 1px 1px #333 -->; color:#333; margin-top:1em <!-- orig: 2em -->; font-weight:700; line-height:1em; font-size:130% <!-- orig: 150% -->;
</xsl:template>


</xsl:stylesheet>