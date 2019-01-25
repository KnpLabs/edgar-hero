import 'react-hyperscript-helpers': { h }
import 'react': { createElement }
import 'react-dom': { render }
import './Component/App': { App }
import './index.sass': sass

render (h App), document.getElementById 'root'
