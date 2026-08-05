---
name: reactbits-dev
description: Library of lightweight, customizable, animated React components. Use when building interactive, micro-animated web interfaces.
category: creative/ui-components
---

# ReactBits — Animated React Components Skill

## Overview
ReactBits provides 60+ animated React components using Framer Motion, CSS animations, and Canvas shaders.

## Key Categories & Components
1. **Text Animations:** SplitText, BlurText, ShinyText, ShinyText, MagnetText.
2. **Backgrounds:** AuroraBackground, ParticlesBackground, WavesBackground, GridDistortion.
3. **Components:** AnimatedCard, SpotlightCard, DockMenu, TiltCard, InfiniteScroll.

## Quick Code Pattern Example (Framer Motion)
```jsx
import { motion } from "framer-motion";

export const ShinyButton = ({ text }) => (
  <motion.button 
    whileHover={{ scale: 1.05 }} 
    whileTap={{ scale: 0.95 }}
    className="bg-gradient-to-r from-blue-500 to-indigo-600 text-white font-bold px-6 py-3 rounded-xl shadow-lg"
  >
    {text}
  </motion.button>
);
```

## How Hermes Uses This
- Instruct Hermes: `"Build a React component using ReactBits AuroraBackground and ShinyButton."`