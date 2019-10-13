
// Create the function.
window.htmlspecialchars_decode = function(string) {
  
  // Our finalized string will start out as a copy of the initial string.
  var unescapedString = string;

  // For each of the special characters,
  var len = htmlspecialchars_decode.specialchars.length;
  for (var x = 0; x < len; x++) {

    // Replace all instances of the entity with the special character.
    unescapedString = unescapedString.replace(
      new RegExp(htmlspecialchars_decode.specialchars[x][1], 'g'),
      htmlspecialchars_decode.specialchars[x][0]
    );
  }

  // Return the unescaped string.
  return unescapedString;
};

window.htmlspecialchars_decode.specialchars = [
  [ '"', '&quot;' ],
  [ '>', '&gt;' ],
  [ '<', '&lt;' ],
  [ '&', '&amp;' ]
];
