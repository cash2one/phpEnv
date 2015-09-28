{%extends "search/searchaladdin/c_base/iphone.tpl"%}

{%block name="data_modifier"%}
    {%$tplData._alaFm="alwz"%}
    {%$tplData.showLeftText = "开发平台"%}
    {%$tplData.showRightUrl = "http://www.baidu.com/"%}
    {%$tplData.showRightText = "查看更多相关结果"%}
    {%$tplData.url="http://m.baidu.com"%}
    {%$tplData.title="我的标题文案"%}
    {%$tplData.len = 3 %}
    
{%/block%}

{%block name="content"%}{%strip%}
    <style>.wa-gcw-wrapper {
  overflow: hidden;
  position: relative;
}
.wa-gcw-scrollor {
  width: 300%;
}
.wa-gcw-scrollor li {
  width: 33.333%;
  height: 300px;
  display: inline-block;
}
.wa-gcw-scrollor li:nth-of-type(1) {
  background-color: red;
}
.wa-gcw-scrollor li:nth-of-type(2) {
  background-color: blue;
}
.wa-gcw-scrollor li:nth-of-type(3) {
  background-color: yellow;
}
</style>
    <div class="wa-gcw-tab">
        
    </div>
    <div class="wa-gcw-wrapper">
        <ul class="wa-gcw-scrollor">
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
    
<script>
</script>
    <script></script>
{%/strip%}{%/block%}

