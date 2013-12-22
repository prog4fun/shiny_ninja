// Datepicker
if (!Modernizr.inputtypes.date) {
     $(function() {
     		$("input[type='date'].editreport").val(function(index, value) {
	     		return $.datepicker.formatDate('dd.mm.yy', new Date(value));
  			});
            $("input[type='date']").datepicker($.datepicker.regional[ "de" ]);
     });
};


// Combobox
(function($) {
    $.widget("custom.combobox", {
        _create: function() {
            this.wrapper = $("<span>")
                    .addClass("custom-autocomplete")
                    .insertAfter(this.element);
            this.element.hide();
            this._createAutocomplete();
            this._createShowAllButton();
        },
        _createAutocomplete: function() {
            var selected = this.element.children(":selected"),
                    value = selected.val() ? selected.text() : "";
            this.input = $("<input>")
                    .appendTo(this.wrapper)
                    .val(value)
                    .attr("title", "")
                    //.addClass("form-control custom-autocomplete-input ui-widget ui-widget-content ui-state-default ui-corner-left")
                    .addClass("form-control ui-corner-left")
                    .autocomplete({
                delay: 0,
                minLength: 0,
                source: $.proxy(this, "_source")
            })
                    .tooltip({
                tooltipClass: "ui-state-highlight"
            });
            this._on(this.input, {
                autocompleteselect: function(event, ui) {
                    ui.item.option.selected = true;
                    this._trigger("select", event, {
                        item: ui.item.option
                    });
                },
                autocompletechange: "_removeIfInvalid"
            });
        },
        _createShowAllButton: function() {
            var input = this.input,
                    wasOpen = false;
            $("<a>")
                    .attr("tabIndex", -1)
                    .attr("title", "Alle Einträge anzeigen")
                    .tooltip()
                    .appendTo(this.wrapper)
                    .button({
                icons: {
                    primary: "ui-icon-triangle-1-s"
                },
                text: false
            })
                    .removeClass("ui-corner-all")
                    .addClass("custom-autocomplete-toggle ui-corner-right")
                    .mousedown(function() {
                wasOpen = input.autocomplete("widget").is(":visible");
            })
                    .click(function() {
                input.focus();
                // Close if already visible
                if (wasOpen) {
                    return;
                }
                // Pass empty string as value to search for, displaying all results
                input.autocomplete("search", "");
            });
        },
        _source: function(request, response) {
            var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
            response(this.element.children("option").map(function() {
                var text = $(this).text();
                if (this.value && (!request.term || matcher.test(text)))
                    return {
                        label: text,
                        value: text,
                        option: this
                    };
            }));
        },
        _removeIfInvalid: function(event, ui) {
            // Selected an item, nothing to do
            if (ui.item) {
                return;
            }
            // Search for a match (case-insensitive)
            var value = this.input.val(),
                    valueLowerCase = value.toLowerCase(),
                    valid = false;
            this.element.children("option").each(function() {
                if ($(this).text().toLowerCase() === valueLowerCase) {
                    this.selected = valid = true;
                    return false;
                }
            });
            // Found a match, nothing to do
            if (valid) {
                return;
            }
            // Remove invalid value
            this.input
                    .val("")
                    .attr("title", value + " wurde nicht gefunden")
                    .tooltip("open");
            this.element.val("");
            this._delay(function() {
                this.input.tooltip("close").attr("title", "");
            }, 2500);
            this.input.data("ui-autocomplete").term = "";
        },
        _destroy: function() {
            this.wrapper.remove();
            this.element.show();
        }
    });
})(jQuery);
$(function() {
    $(".autocomplete").combobox();
    $("#toggle").click(function() {
        $(".autocomplete").toggle();
    });
});





$(function() {
    if (navigator.userAgent.match(/(iPod|iPhone|iPad)/)) {
        $("a[href^='/']").click(function(event) {
            event.preventDefault();
            window.location = $(this).attr('href');
        });

        var comp = new RegExp(location.host);
        $("a").click(function(event) {
            if (comp.test($(this).attr('href'))) {
                event.preventDefault();
                window.location = $(this).attr('href');
            } else {

            }
        });
    } 
});

   

$(function () { 
	// Global variable - cringe
	var visiblePopover;
	
	// enable popovers - all of mine in this instance have a class of .hov
	$("tr.report").popover({
		    html: true,
		    trigger: 'click',
		    placement: 'top',
		    content: function() {
			    var selection = $(this).attr('class').split(' ')[1];
			   return ''+$('.popover_'+selection).html()+'';
		    },
		    container: '#popover_container'
		 });
	
	$("[data-toggle='popover']").on('click', function(e) {
		// don't fall through
		e.stopPropagation();
		var $this = $(this);
		// check if the one clicked is now shown
		if ($('.popover').hasClass('in')) {
			// if another was showing, hide it
			visiblePopover && visiblePopover.popover('toggle');
			// then store the current popover
			visiblePopover = $this;
		} else {
			// if it was hidden, then nothing must be showing
			visiblePopover = '';
		}
	});
	
	// hide all popovers if any non-popover part of the body is clicked
	$("body").on('click', function (e) {
		if ( $(".popover").has(e.target).length === 0) {
			visiblePopover && visiblePopover.popover('toggle');
			visiblePopover = '';
		}
	});
});