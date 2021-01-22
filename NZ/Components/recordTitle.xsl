<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template name="recordTitle">
			<div class="recordTitle">
				<span class="spacer_after_1em"><xsl:value-of select="notification_data/phys_item_display/title" disable-output-escaping="yes"/></span>
			</div>
			<xsl:if test="notification_data/phys_item_display/author !=''">
				<div class="">
					<span class="spacer_after_1em">
						<span class="recordAuthor">@@by@@ <xsl:value-of select="notification_data/phys_item_display/author"/></span>
					</span>
				</div>
			</xsl:if>
			<xsl:if test="notification_data/phys_item_display/isbn !=''">
				<div class="">
					<span class="spacer_after_1em">
						<span class="recordAuthor">ISBN: <xsl:value-of select="notification_data/phys_item_display/isbn"/></span>
					</span>
				</div>
			</xsl:if>
			<xsl:if test="notification_data/phys_item_display/issn !=''">
				<div class="">
					<span class="spacer_after_1em">
						<span class="recordAuthor">ISSN: <xsl:value-of select="notification_data/phys_item_display/issn"/></span>
					</span>
				</div>
			</xsl:if>
			<xsl:if test="notification_data/phys_item_display/issue_level_description !=''">
				<div class="">
					<span class="spacer_after_1em">
						<span class="volumeIssue">@@description@@ <xsl:value-of select="notification_data/phys_item_display/issue_level_description"/></span>
					</span>
				</div>
			</xsl:if>

</xsl:template>

</xsl:stylesheet>