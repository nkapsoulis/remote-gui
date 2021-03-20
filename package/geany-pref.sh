#!/bin/bash

# RUN IT AFTER CHANGING ONE KEYBINDING, SO THAT keybinding.conf APPEARS
sed -e 's/menu_redo=.*/menu_redo=<Primary><Shift>z/' \
	-e 's/edit_commentlinetoggle=.*/edit_commentlinetoggle=<Primary>slash/' \
	-e 's/edit_movelineup=.*/edit_movelineup=<Primary><Shift>Up/' \
	-e 's/edit_movelinedown=.*/edit_movelinedown=<Primary><Shift>Down/' \
	/data/.config/geany/keybindings.conf > temp
mv temp /data/.config/geany/keybindings.conf # COPY/CUT CURRENT LINE=CTRL+SHIFT+C/X

# Custom monokai.conf
mkdir -p /data/.config/geany/colorschemes/ 
wget -O - https://raw.githubusercontent.com/geany/geany-themes/master/colorschemes/monokai.conf > /data/.config/geany/colorschemes/monokai.conf
sed -e 's/type=.*/type=bright_green/' \
	-e 's/keyword=.*/keyword=hot_pink/' \
	-e 's/keyword_2=.*/keyword_2=light_cyan;;;true/' \
	-e 's/operator=.*/operator=hot_pink/' \
	/data/.config/geany/colorschemes/monokai.conf > temp
mv temp /data/.config/geany/colorschemes/monokai.conf

# geany.conf
sed -e 's/color_scheme=.*/color_scheme=monokai.conf/' -e 's/long_line_column=.*/long_line_column=86/' \
	-e 's/run_in_vte=.*/run_in_vte=true/' -e 's/symbolcompletion_min_chars=.*/symbolcompletion_min_chars=1/' \
	-e 's/pref_toolbar_append_to_menu=.*/pref_toolbar_append_to_menu=true/' \
	-e 's/comment_toggle_mark=.*/comment_toggle_mark= /' \
	-e 's/completion_drops_rest_of_word=.*/completion_drops_rest_of_word=true/' \
	-e 's/auto_complete_symbols=.*/auto_complete_symbols=true/' \
	-e 's/complete_snippets=.*/complete_snippets=true/' \
	-e 's/autocomplete_doc_words=.*/autocomplete_doc_words=true/' \
	-e 's/autoclose_chars=.*/autoclose_chars=31/' \
	/data/.config/geany/geany.conf > temp
mv temp /data/.config/geany/geany.conf


echo "
<ui>
<!--
This is Geany's toolbar UI definition.
The DTD can be found at 
http://library.gnome.org/devel/gtk/stable/GtkUIManager.html#GtkUIManager.description.

You can re-order all items and freely add and remove available actions.
You cannot add new actions which are not listed in the documentation.
Everything you add or change must be inside the /ui/toolbar/ path.

For changes to take effect, you need to restart Geany. Alternatively you can use the toolbar
editor in Geany.

A list of available actions can be found in the documentation included with Geany or
at https://www.geany.org/manual/current/index.html#customizing-the-toolbar.
-->
	<toolbar name='GeanyToolbar'>
		<toolitem action='Compile' />
		<toolitem action='Run' />
		<separator/>
		<toolitem action='New' />
		<toolitem action='Open' />
		<toolitem action='Save' />
		<toolitem action='SaveAll' />
		<separator/>
		<toolitem action='Reload' />
		<toolitem action='Close' />
		<toolitem action='NavBack' />
		<toolitem action='NavFor' />
		<separator/>
		<toolitem action='Build' />
		<separator/>
		<toolitem action='Color' />
		<separator/>
		<toolitem action='SearchEntry' />
		<toolitem action='Search' />
		<separator/>
		<toolitem action='GotoEntry' />
		<toolitem action='Goto' />
		<separator/>
		<toolitem action='Quit' />
	</toolbar>
</ui>
" > /data/.config/geany/ui_toolbar.xml