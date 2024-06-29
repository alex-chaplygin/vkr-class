chrome.action.onClicked.addListener((tab) => {
  chrome.storage.sync.get(
    { lib_file: 'data.json', lib_pos: 1 },
    (items) => {
      let file = items.lib_file;
	let pos = items.lib_pos;
	console.log('pos', pos);
	let url = "file://" + file;
	fetch(url).then(r => r.json()).then(function (values) {
	    if (pos >= values.length) {
		pos = 0;
	    }
	    vals = values[pos];
	    pos++;
	    chrome.storage.sync.set({lib_pos: pos});
	    chrome.scripting.executeScript({
		target: {tabId: tab.id},
		func: fillTable,
		args: [vals],
	    });
	});
    }
  );
});

function fillTable(values) {
    let ids = ["sys_code", "author", "supervisor", "critic", "title", "keywords", "annotation",
	       "year1", "pages_count", "publishing", "ui-spec", "ui-kafv", "ui-vo"];
    for (let i = 0; i < 10/*ids.length*/; i++) {
	let l = document.getElementById(ids[i]);
	l.value = values[i];
	l.dispatchEvent(new Event('change'));
    }
}
