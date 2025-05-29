document.addEventListener("turbo:load", function () {
  const userIdInput = document.getElementById("user_id_input");
  const userNameDisplay = document.getElementById("user_name_display");

  if (!userIdInput) return;

  userIdInput.addEventListener("blur", function () {
    const userId = userIdInput.value;
    if (userId.trim() === "") {
      userNameDisplay.textContent = "";
      return;
    }

    fetch(`/xx_user_ids/fetch_username?user_id=${encodeURIComponent(userId)}`)
      .then(response => response.json())
      .then(data => {
        userNameDisplay.textContent = data.user_name || "不明なユーザー";
      })
      .catch(() => {
        userNameDisplay.textContent = "取得失敗";
      });
  });
});
