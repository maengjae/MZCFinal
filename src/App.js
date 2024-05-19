import './App.css';
import Appbar from "./components/Appbar"
import Cosmetic from "./components/Cosmetics"
import CosmeticDetail from './components/CosmeticDetail';

function App() {
  return (
    <div className="App">
    <Appbar/>
    <Cosmetic/>
    <Route path="cosmetic/:id" element={<CosmeticDetail />} />
    </div>
  );
}

export default App;
