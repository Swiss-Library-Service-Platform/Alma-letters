<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<!-- Searches the message node for a row with Library name that gets inserted automatically from Alma-->
<xsl:template name="getLibrary">

    <xsl:choose>
        <xsl:when test="contains(notification_data/conversation_messages/message, 'Library Name:')">
            <xsl:variable name="message_rows" select="str:split(notification_data/conversation_messages/message/message_body,'&lt;br&gt;')" />
            <xsl:for-each select="$message_rows">
                <xsl:if test="contains(., 'Library Name:')">
                    <xsl:value-of select="str:split(., 'Library Name:')[2]"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:when>
        <xsl:when test="contains(notification_data/conversation_messages/message, 'Bibliothekname:')">
            <xsl:variable name="message_rows" select="str:split(notification_data/conversation_messages/message/message_body,'&lt;br&gt;')" />
            <xsl:for-each select="$message_rows">
                <xsl:if test="contains(., 'Bibliothekname:')">
                    <xsl:value-of select="str:split(., 'Bibliothekname:')[2]"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:when>
        <xsl:when test="contains(notification_data/conversation_messages/message, 'Nome Biblioteca:')">
            <xsl:variable name="message_rows" select="str:split(notification_data/conversation_messages/message/message_body,'&lt;br&gt;')" />
            <xsl:for-each select="$message_rows">
                <xsl:if test="contains(., 'Nome Biblioteca:')">
                    <xsl:value-of select="str:split(., 'Nome Biblioteca:')[2]"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:when>
        <xsl:when test="contains(notification_data/conversation_messages/message, 'Nom de la bibliothèque:')">
            <xsl:variable name="message_rows" select="str:split(notification_data/conversation_messages/message/message_body,'&lt;br&gt;')" />
            <xsl:for-each select="$message_rows">
                <xsl:if test="contains(., 'Nom de la bibliothèque:')">
                    <xsl:value-of select="str:split(., 'Nom de la bibliothèque:')[2]"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:when>

    </xsl:choose>
</xsl:template>

<xsl:template match="/">

	<html>
			<xsl:if test="notification_data/languages/string">
				<xsl:attribute name="lang">
					<xsl:value-of select="notification_data/languages/string"/>
				</xsl:attribute>
			</xsl:if>

		<head>
				<title>
					<xsl:value-of select="notification_data/general_data/subject"/>
				</title>

		<xsl:call-template name="generalStyle" />
		</head>

			<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
            

				<xsl:call-template name="head" /> <!-- header.xsl -->
				<!--<xsl:call-template name="senderReceiver" /> --><!-- SenderReceiver.xsl -->
				<!--<xsl:call-template name="toWhomIsConcerned" />--><!-- mailReason.xsl -->
                    
                <xsl:variable name="library">
                    <xsl:call-template name="getLibrary" />
                </xsl:variable>
                
				<xsl:for-each select="notification_data/conversation_messages/message">
                    <table>
                        <tr>
                            <td><h2><xsl:value-of select="message_subject"/></h2></td>
                        </tr>
                        <tr>
                            <td>
                                <xsl:value-of select="message_body" disable-output-escaping="yes"/>
                            </td>
                        </tr>
                    </table>
                </xsl:for-each>
				<br />
                <table>
                    <tr><td>@@sincerely@@<br /></td></tr>
                    <tr>
                        <td><xsl:value-of select="notification_data/conversation_messages/message/author/first_name" />&#160;
                        <xsl:value-of select="notification_data/conversation_messages/message/author/last_name" /><br /></td>
                    </tr>
                    <!-- library name is not in the XML metadata, we need to extract it from the first message -->
                    <xsl:if test="$library != ''">
                        <tr>
                            <td><xsl:value-of select="$library" /><br /></td>
                        </tr>
                    </xsl:if>
                    <tr><td><xsl:value-of select="notification_data/organization_unit/name" /></td></tr>
                    <tr>
                        <td><br/><i>powered by SLSP</i></td>
                    </tr>
				</table>
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>