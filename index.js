const bearychat = require('bearychat')
bearychat.rtm.start({token: '87e0dd8dc40e593810f694f13f5aa651'})
             .then(resp => resp.json())
             .then(data => { console.log(data)} )
