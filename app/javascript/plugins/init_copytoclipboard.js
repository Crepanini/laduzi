function selectElementContents(el) {
    // Copy textarea, pre, div, etc.
    if (document.body.createTextRange) {
        // IE
        var textRange = document.body.createTextRange();
        textRange.moveToElementText(el);
        textRange.select();
        textRange.execCommand("Copy");
    } else if (window.getSelection && document.createRange) {
        // non-IE
        var range = document.createRange();
        range.selectNodeContents(el);
        var sel = window.getSelection();
        sel.removeAllRanges();
        sel.addRange(range);
        try {
            var successful = document.execCommand('copy');
            var msg = successful ? 'successful' : 'unsuccessful';
            console.log('Copy command was ' + msg);
        } catch (err) {
            console.log('Oops, unable to copy');
        }
    }
} // end function selectElementContents(el)

function make_copy_button(el) {
    var copy_btn = document.createElement('input');
    copy_btn.type = "button";
    el.parentNode.insertBefore(copy_btn, el.nextSibling);
    copy_btn.onclick = function() {
        selectElementContents(el);
    };

    if (document.queryCommandSupported("copy") || parseInt(navigator.userAgent.match(/Chrom(e|ium)\/([0-9]+)\./)[2]) >= 42) {
        // Copy works with IE 4+, Chrome 42+, Firefox 41+, Opera 29+
        copy_btn.value = "Copy"
    } else {
        // Select only for Safari and older Chrome, Firefox and Opera
        copy_btn.value = "Select All (then press CTRL+C to Copy)";
    }
}
/* Note: document.queryCommandSupported("copy") should return "true" on browsers that support copy
  but there was a bug in Chrome versions 42 to 47 that makes it return "false".  So in those
  versions of Chrome feature detection does not work!
  See https://code.google.com/p/chromium/issues/detail?id=476508
*/

make_copy_button(document.getElementById("markup"));

export { make_copy_button }
