import './App.css';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Appbar from "./components/Appbar";
import Cosmetic from "./components/Cosmetics";
import CosmeticDetail from './components/CosmeticDetail';

function App() {
  return (
    
    <Router>
      <div className="App">
        <Appbar />
        <Routes>
          <Route path="/" element={<Cosmetic />} />
          <Route path="/cosmetic/:id" element={<CosmeticDetail />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
