import { Controller } from "stimulus"
export default class extends Controller {
    static targets = [ "public" ]
    toggle(event) {
      let formData = new FormData()
      formData.append("todo[public]", this.publicTarget.checked);
    
      fetch(this.data.get("update-url"), {
        body: formData,
        method: 'PATCH',
        credentials: "include",
        dataType: "script",
        headers: {
                "X-CSRF-Token": getMetaValue("csrf-token")
        },
      })
      .then(function(response) {
        if (response.status != 204) {
            event.target.checked = !event.target.checked
            alert(response.status)
        }
    })
  }
}