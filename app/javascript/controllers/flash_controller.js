import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.remove();
    }, 3000); // 3秒後にフラッシュメッセージを自動的に消去
  }
}
