<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />

  <xsl:template match="/">
    <html>
      <head>
        <xsl:call-template name="generalStyle" />
      </head>
      <body>
        <xsl:attribute name="style">
          <xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
        </xsl:attribute>

        <xsl:call-template name="head" /><!-- header.xsl -->
        <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

		<br />
		<!-- <xsl:call-template name="toWhomIsConcerned" />  mailReason.xsl commented out 2017-12-18/Grm -->
	<div class="messageArea" >
                <div class="messageBody">


        	<table cellspacing="0" cellpadding="0" border="0" style="margin-top: 6cm; margin-bottom: 2cm;"> <!-- was: cellpadding = 5, no margins. Added for direct printing 2019-09-11/Grm -->
				<!-- commented out 2017-12-18/Grm
				<tr>
				<td>
					<h>@@inform_loaned_items@@ <xsl:value-of select="notification_data/organization_unit/name" />&#58;&#160;</h>
				</td>
				</tr>

				<tr>
              	<td>
					<b>@@loans@@ <xsl:value-of select="notification_data/items/item_loan/loan_date"/></b>
                </td>
              	</tr> -->

              	<tr>
                <td>
                	<table cellpadding="0" class="listing">
						<xsl:attribute name="style">
							<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
						</xsl:attribute>
						<tr>
							<th style="min-width: 50%">@@title@@</th>
									<!-- 2017-11-28/Grm <th>@@author@@</th> 
							<th>@@loan_date@@</th>-->
							<th>@@due_date@@</th>
							<xsl:choose>
									<xsl:when test="//preferred_language='it'">
										  <th>Collocazione</th>										  
									</xsl:when>
									<xsl:when test="//preferred_language='fr'">
										  <th>Cote</th>										  
									</xsl:when>
									<xsl:when test="//preferred_language='en'">
										  <th>Call number</th>										  
									</xsl:when>
									<xsl:otherwise>
										  <th>Signatur</th>
									</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="notification_data/items/item_loan/description!=''">
								<th>@@description@@</th>
							</xsl:if>
							<!--<xsl:choose>
									<xsl:when test="//preferred_language='fr'">
										  <th>Code-barres</th>										  
									</xsl:when>
									<xsl:when test="//preferred_language='de'">
										  <th>Strichcode</th>										  
									</xsl:when>
									<xsl:otherwise>
										  <th>Barcode</th>
									</xsl:otherwise>
							</xsl:choose>-->
							
						</tr>

                		<xsl:for-each select="notification_data/items/item_loan">
						<tr>
							<td><xsl:value-of select="title"/></td>
							<!-- <td><xsl:value-of select="author"/></td> 
							<td><xsl:value-of select="loan_date"/></td> -->
							<td><xsl:value-of select="due_date"/></td>
							<td><xsl:value-of select="call_number"/></td>
							<xsl:if test="//notification_data/items/item_loan/description!=''">
								<td><xsl:value-of select="description"/></td>
							</xsl:if>
							<!--<td><xsl:value-of select="barcode"/></td>-->							
						</tr>
						</xsl:for-each>

                	</table>
                </td>
              </tr>
			</table>

			<table>
				<tr><td><!--@@sincerely@@  commented out 2017-12-18/Grm --></td></tr>
				<tr><td><h4>@@department@@</h4></td></tr>
			</table>

	  		</div>
        </div>
        <!-- footer.xsl -->
        <xsl:call-template name="lastFooter" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
