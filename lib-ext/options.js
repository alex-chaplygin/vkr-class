const saveOptions = () => {
  const file = document.getElementById('file').value;
  const pos = document.getElementById('pos').value;

  chrome.storage.sync.set(
    { lib_file: file, lib_pos: pos },
    () => {
      // Update status to let user know options were saved.
      const status = document.getElementById('status');
      status.textContent = 'Настройки сохранены';
      setTimeout(() => {
        status.textContent = '';
      }, 750);
    }
  );
};

const restoreOptions = () => {
  chrome.storage.sync.get(
    { lib_file: 'data.json', lib_pos: 1 },
    (items) => {
      document.getElementById('file').value = items.lib_file;
      document.getElementById('pos').value = items.lib_pos;
    }
  );
};

document.addEventListener('DOMContentLoaded', restoreOptions);
document.getElementById('save').addEventListener('click', saveOptions);
