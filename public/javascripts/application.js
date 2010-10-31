// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Emmett = {
  preview: function (form) {
    $('preview').update(
      '<img src="/images/spinner.gif" alt=""/> Loading preview...');
    new Ajax.Request('/entries/5-rdoc-test', {
      parameters: form.serialize() + '&preview=1',
      onSuccess: function (response) {
        $('preview').update(response.responseText);
      }
    });
  }
};
