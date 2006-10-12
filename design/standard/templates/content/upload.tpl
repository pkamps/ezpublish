{* DO NOT EDIT THIS FILE! Use an override template instead. *}
<form enctype="multipart/form-data" action={'content/upload'|ezurl} method="post">

{section show=$upload.description_template}
    {include name=Description uri=$upload.description_template upload=$upload}
{section-else}
    <div class="maincontentheader">
    <h1>{"Upload file"|i18n("design/standard/content/upload")}</h1>
    </div>

    <p>{'Choose a file from your locale machine and click the "Upload" button. An object will be created according to file type and placed in your chosen location.'|i18n("design/standard/content/upload")}</p>
{/section}

{section show=$errors|count|gt( 0 )}
    <div class="error">
        <h2>{"Some errors occurred"|i18n( "design/standard/content/upload" )}</h2>
        <ul>
            {section var=error loop=$errors}
                <li>{$error.description}</li>
            {/section}
        </ul>
    </div>
{/section}

<input type="hidden" name="UploadActionName" value="{$upload.action_name}" />

<div class="createblock">
    <label>{'Location'|i18n( 'design/standard/content/upload' )}</label>
    <select	name="UploadLocationChoice" class="combobox locationchoice">
        <option value="auto">{'Automatic'|i18n( 'design/standard/content/upload' )}</option>

{def $root_node_value=ezini( 'LocationSettings', 'RootNode', 'upload.ini' )
     $root_node=cond( $root_node_value|is_numeric, fetch( content, node, hash( node_id, $root_node_value ) ),
                      fetch( content, node, hash( node_path, $root_node_value ) ) )
     $selection_list=fetch( 'content', 'tree',
                            hash( 'parent_node_id', $root_node.node_id,
                            'class_filter_type', include,
                            'class_filter_array', ezini( 'LocationSettings', 'ClassList', 'upload.ini' ),
                            'depth', ezini( 'LocationSettings', 'MaxDepth', 'upload.ini' ),
                            'depth_operator', 'lt',
                            'limit', ezini( 'LocationSettings', 'MaxItems', 'upload.ini' ) ) )}

{foreach $selection_list as $selection}
        {if $selection.can_create}
          <option value="{$selection.node_id}">{'&nbsp;'|repeat( sub( $selection.depth, $root_node.depth, 1 ) )}{$selection.name|wash}</option>
        {/if}
{/foreach}
{undef $root_node_value $root_node $selection_list}
  	</select>

</div>

<div class="createblock">
    <input type="hidden" name="MAX_FILE_SIZE" value="50000000" />
    <input name="UploadFile" type="file" />
    &nbsp;

    <input class="defaultbutton" type="submit" name="UploadFileButton" value="{'Upload'|i18n( 'design/standard/content/upload' )}" title="{'Click here to upload a file. The file will be placed within the location that is specified using the dropdown menu on the top.'|i18n( 'design/standard/content/upload' )}" />

 </div>
</form>
