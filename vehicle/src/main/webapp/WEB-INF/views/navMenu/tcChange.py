count = int(input("데이터 몇 개 ? --> "))

name = []
leCount = []
reCount = []
fullName = ""

print("데이터셋 입력 시작")

for i in range(0,count):
    name.append(input())

print("왼쪽 숫자 입력 시작")
for i in range(0,count):
    leCount.append(input())

print("오른쪽 숫자 입력 시작")
for i in range(0,count):
    reCount.append(input())

header = '''<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="fn"  xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" exclude-result-prefixes="xs fn">
  <xsl:output method="xml" indent="yes" encoding="UTF-8" />
  
  <xsl:param name="filePath"/>

  <xsl:template match="/" name="main">
  <xsl:variable name="lineItems" select="unparsed-text($filePath, 'UTF-8')" />
 
  <XMLDATA>
  
  <ROW SEQ="1" INDEX="1" COUNT="1">
  <TCDATA TYPE ="VARCHAR2" >
	   <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>   
	   <xsl:value-of select="$lineItems" />
	   <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>	
  </TCDATA>
'''
footer = '''</ROW>
    </XMLDATA> 
    </xsl:template>
    </xsl:stylesheet>
'''

for i in range(0, count):
    fullName += f"""
    <{name[i]} TYPE ="VARCHAR" >
        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
        <xsl:value-of select="normalize-space(substring($lineItems,{leCount[i]},{reCount[i]}))" />
        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
    </{name[i]}>
    """
    
print("=====================================================================================================================")
print(header + fullName + footer)
print("=====================================================================================================================")
