<%--

    Copyright (C) 2012 JBoss Inc

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

          http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

--%>
<%@ page import="org.jbpm.formModeler.service.bb.commons.config.LocaleManager"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="org.jbpm.formModeler.components.editor.WysiwygFormEditor" %>
<%@ taglib uri="mvc_taglib.tld" prefix="mvc" %>
<%@ taglib prefix="static" uri="static-resources.tld" %>
<%@ taglib uri="http://jakarta.apache.org/taglibs/i18n-1.0" prefix="i18n" %>
<%@ taglib uri="factory.tld" prefix="factory" %>

<i18n:bundle id="bundle" baseName="org.jbpm.formModeler.components.editor.messages"
             locale="<%=LocaleManager.currentLocale()%>"/>


<mvc:formatter name="org.jbpm.formModeler.components.editor.FieldEditionFormatter">
<%------------------------------------------------------------------------------------------------------------%>
<mvc:fragment name="outputStart">
    <script type="text/javascript" xml:space="preserve">
        function modifyAllSelects(visibilityStyle){
            var selects = document.getElementsByTagName('select');
            for(i=0; i<selects.length; i++){
                selects[i].style.visibility=visibilityStyle;
            }
        }
        function showTooltip(divId){
            modifyAllSelects('hidden');
            document.getElementById("hidderDiv").style.display='block';
            document.getElementById(divId).style.display='block';
        }
        function hideTooltip(divId){
            document.getElementById(divId).style.display='none';
            document.getElementById("hidderDiv").style.display='none';
            modifyAllSelects('visible');
        }

    </script>
    <div style="overflow: scroll; height: 600px; " id="<factory:encode name="fieldProperties"/>">
    <form action="<factory:formUrl/>" id="<factory:encode name="updateFormField"/>" method="POST" enctype="multipart/form-data">
    <factory:handler bean="org.jbpm.formModeler.components.editor.WysiwygFormEditor" action="saveFieldProperties"/>
    <input type="hidden" name="<%=WysiwygFormEditor.ACTION_TO_DO%>" id="<factory:encode name="actionToDo"/>" value="<%=WysiwygFormEditor.ACTION_SAVE_FIELD_PROPERTIES%>"/>
    <table class="skn-table_border" width="100%" bgcolor="#FFFFFF">
    <tr>
    <td>
    <table cellspacing="1" cellpadding="1"  width="100%">
    <tr class="skn-odd_row">
        <td><i18n:message key="fieldType">!!!Tipo de campo</i18n:message></td>
        <td></td>
        <td>
            <mvc:formatter name="org.jbpm.formModeler.components.editor.FieldAvailableTypesFormatter">
                <mvc:fragment name="outputStart">
                    <select name="fieldType" class="skn-input" style="width:200px" onchange="$('#<factory:encode name="actionToDo"/>').val('<%=WysiwygFormEditor.ACTION_CHANGE_FIELD_TYPE%>'); submitAjaxForm(this.form);">
                </mvc:fragment>
                <mvc:fragment name="output">
                    <mvc:fragmentValue name="id" id="id">
                        <option value="<%=id%>"><i18n:message key="<%="fieldType." + id%>"/></option>
                    </mvc:fragmentValue>
                </mvc:fragment>
                <mvc:fragment name="outputSelected">
                    <mvc:fragmentValue name="id" id="id">
                        <option value="<%=id%>" selected><i18n:message key="<%="fieldType." + id%>"/></option>
                    </mvc:fragmentValue>
                </mvc:fragment>
                <mvc:fragment name="outputEnd">
                    </select>
                </mvc:fragment>
                <mvc:fragment name="empty">
                    <input type="hidden" name="fieldType" value="<mvc:fragmentValue name="id"/>">
                </mvc:fragment>
            </mvc:formatter>
        </td>
        <td></td>
    </tr>
</mvc:fragment>
<%------------------------------------------------------------------------------------------------------------%>
<mvc:fragment name="fieldCustomFormulary">
    <mvc:fragmentValue name="formId" id="formularyId">
        <mvc:fragmentValue name="namespace" id="formNamespace">
            <mvc:fragmentValue name="editClass" id="editClass">
                <mvc:fragmentValue name="editId" id="editId">
                    <mvc:fragmentValue name="formValues" id="formValues">
                        <mvc:fragmentValue name="fieldType" id="fieldType">

                            <mvc:formatter name="org.jbpm.formModeler.core.processing.formRendering.FormRenderingFormatter">
                                <mvc:formatterParam name="formId" value="<%=formularyId%>"/>
                                <mvc:formatterParam name="namespace" value="<%=formNamespace%>"/>
                                <mvc:formatterParam name="editId" value="<%=editId%>"/>
                                <mvc:formatterParam name="editClass" value="<%=editClass%>"/>
                                <mvc:formatterParam name="formValues" value="<%=formValues%>"/>
                                <mvc:fragment name="beforeInputElement">
                                    <mvc:fragmentValue name="field/position" id="position">
                                        <tr class="<%=((Integer)position).intValue()%2==0?"skn-even_row":"skn-odd_row"%>" >
                                    </mvc:fragmentValue>
                                </mvc:fragment>

                                <mvc:fragment name="beforeLabel"><td valign="top"></mvc:fragment>
                                <mvc:fragment name="afterLabel"></td></mvc:fragment>
                                <mvc:fragment name="beforeField">
                                    <mvc:fragmentValue name="field" id="field">
                                        <td>
                                            <div style="width:140px; overflow:hidden;"  nowrap="nowrap">
                                    <span onmouseover="return escape(this.innerHTML)" style="padding:0px;">
                                    <mvc:formatter name="org.jbpm.formModeler.components.editor.FieldTypePropertyFormatter">
                                        <mvc:formatterParam name="field" value="<%=field%>"/>
                                        <mvc:formatterParam name="type" value="<%=fieldType%>"/>
                                    </mvc:formatter>
                                    </span>
                                            </div>
                                        </td>
                                        <td>
                                    </mvc:fragmentValue>
                                </mvc:fragment>
                                <mvc:fragment name="afterField">
                                    <mvc:fragmentValue name="field" id="field">
                                        <mvc:fragmentValue id="fieldPosition" name="field/position">
                                            </td>
                                            <td>
                                                <mvc:formatter name="org.jbpm.formModeler.components.editor.FieldPropertyTooltipFormatter">
                                                    <mvc:formatterParam name="field" value="<%=field%>"/>
                                                    <mvc:fragment name="output">
                                                        <mvc:fragmentValue name="help" id="help">
                                                            <a href="#" onclick="showTooltip('<%="tooltipDiv_"+fieldPosition%>');return false;">
                                                                <img src="<static:image relativePath="general/16x16/ico-info.png"/>" border="0" />
                                                            </a>
                                                            <div style="position:absolute; display:none; width:100%; height:100; padding:20px; z-index:100;" id='<%="tooltipDiv_"+fieldPosition%>'>
                                                                <div style=" background-color: rgb(255, 255, 175); padding:10px; position:relative; left:-330px; top:-40px; width:300px; z-index:100">
                                                                    <div align="right">
                                                                        <a href="#" onclick="hideTooltip('<%="tooltipDiv_"+fieldPosition%>');return false;">
                                                                            <img src="<static:image relativePath="general/16x16/ico-process-stop.png"/>" border="0" />
                                                                        </a>
                                                                    </div>
                                                                    <%=StringEscapeUtils.unescapeHtml((String)help)%>
                                                                </div>
                                                            </div>
                                                        </mvc:fragmentValue>
                                                    </mvc:fragment>
                                                </mvc:formatter>
                                            </td>
                                        </mvc:fragmentValue>
                                    </mvc:fragmentValue>
                                </mvc:fragment>
                                <mvc:fragment name="afterInputElement"></tr></mvc:fragment>
                            </mvc:formatter>

                        </mvc:fragmentValue>
                    </mvc:fragmentValue>
                </mvc:fragmentValue>
            </mvc:fragmentValue>
        </mvc:fragmentValue>
    </mvc:fragmentValue>
</mvc:fragment>
<%------------------------------------------------------------------------------------------------------------%>
<mvc:fragment name="outputName">
    <mvc:fragmentValue name="index" id="index">
        <mvc:fragmentValue name="name" id="name">
            <tr class="<%=((Integer) index).intValue() % 2 == 0 ? "skn-even_row" : "skn-odd_row"%>">
            <td>
                <i18n:message key='<%="field."+name%>'><%=name%></i18n:message>
            </td>
        </mvc:fragmentValue>
    </mvc:fragmentValue>
</mvc:fragment>
<%------------------------------------------------------------------------------------------------------------%>
<mvc:fragment name="beforeDefaultValue">
    <td>
</mvc:fragment>
<%------------------------------------------------------------------------------------------------------------%>
<mvc:fragment name="afterDefaultValue">
    </td>
</mvc:fragment>
<%------------------------------------------------------------------------------------------------------------%>
<mvc:fragment name="beforeInput">
    <td>
</mvc:fragment>
<%------------------------------------------------------------------------------------------------------------%>
<mvc:fragment name="afterInput">
    </td>
</mvc:fragment>
<%------------------------------------------------------------------------------------------------------------%>
<mvc:fragment name="cantShowInput">
    <td>-</td>
</mvc:fragment>
<%------------------------------------------------------------------------------------------------------------%>
<mvc:fragment name="errorShowingInput">
    <td colspan="2"></td>
</mvc:fragment>
<%------------------------------------------------------------------------------------------------------------%>
<mvc:fragment name="outputNameEnd">
    </tr>
</mvc:fragment>
<%------------------------------------------------------------------------------------------------------------%>
<mvc:fragment name="outputEnd">
    <tr>
        <td align="center" colspan="3">
            <table>
                <tr>
                    <td><input type="submit" value="<i18n:message key="save"> !!!Save </i18n:message>" class="skn-button"
                               onclick="$('#<factory:encode name="actionToDo"/>').val('<%=WysiwygFormEditor.ACTION_SAVE_FIELD_PROPERTIES%>');"></td>
                    <td><input type="submit" value="<i18n:message key="cancel"> !!!Cancel </i18n:message>" class="skn-button"
                               onclick="$('#<factory:encode name="actionToDo"/>').val('<%=WysiwygFormEditor.ACTION_CANCEL_FIELD_EDITION%>');"></td>
                </tr>
            </table>

        </td>
    </tr>
    </table>

    </td>
    </tr>
    </table>
    </form>
    </div>
    <script type="text/javascript" defer="defer">
        setAjax("<factory:encode name="updateFormField"/>");

    </script>
    <script type="text/javascript">
        $(function() {
            $( '#<factory:encode name="fieldProperties"/>' ).dialog({
                modal: false,
                draggable: false,
                closeOnEscape: false,
                position: "right top",
                maxHeight: 700,
                width: 600,
                open: function() { $(".ui-dialog-titlebar").show();}
            });
        });
    </script>
</mvc:fragment>
</mvc:formatter>
