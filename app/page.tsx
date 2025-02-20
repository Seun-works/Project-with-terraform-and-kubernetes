import styles from "./page.module.css";

export default function Home() {
  return (
    <div className={styles.page}>
      <main className={styles.main}>
        <div>
          <p>
            Welcome to this Next.js app! This is a simple example of a Next.js
            app that uses TypeScript, ESLint, Prettier, and CSS Modules. That is currently running in a kubernetes cluster on Amazon&apos;s EKS.
          </p>
        </div>
      </main>
      <footer className={styles.footer}>
      </footer>
    </div>
  );
}
