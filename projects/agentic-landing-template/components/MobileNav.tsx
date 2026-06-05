"use client";

import { useEffect, useRef, useState } from "react";
import { MenuIcon, CloseIcon } from "./Icons";

export function MobileNav() {
  const [isOpen, setIsOpen] = useState(false);
  const toggleButtonRef = useRef<HTMLButtonElement | null>(null);
  const firstLinkRef = useRef<HTMLAnchorElement | null>(null);
  const wasOpenRef = useRef(false);

  const toggleMenu = () => setIsOpen(!isOpen);
  const closeMenu = () => setIsOpen(false);

  useEffect(() => {
    if (isOpen) {
      firstLinkRef.current?.focus();
    } else if (wasOpenRef.current) {
      toggleButtonRef.current?.focus();
    }
    wasOpenRef.current = isOpen;
  }, [isOpen]);

  useEffect(() => {
    if (!isOpen) {
      return;
    }

    const handleKeyDown = (event: KeyboardEvent) => {
      if (event.key === "Escape") {
        event.preventDefault();
        closeMenu();
      }
    };

    document.addEventListener("keydown", handleKeyDown);
    return () => document.removeEventListener("keydown", handleKeyDown);
  }, [isOpen]);

  return (
    <div className="md:hidden">
      {/* Hamburger Button */}
      <button
        onClick={toggleMenu}
        ref={toggleButtonRef}
        className="p-2 text-slate-600 dark:text-slate-300 hover:text-blue-600 dark:hover:text-blue-400 transition-colors"
        aria-label={isOpen ? "Close menu" : "Open menu"}
        aria-expanded={isOpen}
        aria-controls="mobile-menu"
      >
        {isOpen ? <CloseIcon /> : <MenuIcon />}
      </button>

      {/* Mobile Menu Overlay */}
      {isOpen ? (
        <>
          <div
            className="fixed inset-0 z-40 bg-black/50 backdrop-blur-sm"
            onClick={closeMenu}
            aria-hidden="true"
          />
          <div
            id="mobile-menu"
            className="fixed top-16 right-0 z-50 w-64 h-[calc(100vh-4rem)] bg-white dark:bg-slate-900 border-l border-slate-200 dark:border-slate-800 transform translate-x-0 transition-transform duration-300 ease-in-out"
            role="dialog"
            aria-modal="true"
            aria-label="Mobile navigation menu"
          >
            <nav className="flex flex-col p-6 space-y-4">
              <a
                href="#about"
                onClick={closeMenu}
                ref={firstLinkRef}
                className="text-base font-medium text-slate-300 hover:text-cyan-400 transition-colors py-2"
              >
                About
              </a>
              <a
                href="#features"
                onClick={closeMenu}
                className="text-base font-medium text-slate-300 hover:text-cyan-400 transition-colors py-2"
              >
                Features
              </a>
              <a
                href="#how-it-works"
                onClick={closeMenu}
                className="text-base font-medium text-slate-300 hover:text-cyan-400 transition-colors py-2"
              >
                How It Works
              </a>
              <a
                href="#waitlist"
                onClick={closeMenu}
                className="bg-cyan-500 hover:bg-cyan-400 text-slate-950 px-4 py-3 rounded-lg text-base font-semibold transition-colors text-center mt-4"
              >
                Join Waitlist
              </a>
            </nav>
          </div>
        </>
      ) : null}
    </div>
  );
}
