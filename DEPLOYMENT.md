# 🚀 Deployment Guide - Vercel dengan Fork Strategy

Panduan lengkap untuk deploy project ini ke Vercel menggunakan fork repository sambil tetap sync dengan repository team.

## 📋 Ringkasan Strategi

Karena Vercel memerlukan akses ke repository pribadi Anda, kita akan:
1. **Fork** repository team ke akun GitHub pribadi Anda
2. Setup **dual remote** (origin untuk fork Anda, upstream untuk repo team)
3. Deploy ke Vercel dari fork Anda
4. Sync perubahan dari team repo secara berkala

---

## 🔧 Setup Awal

### Step 1: Fork Repository

1. Buka repository team di GitHub:
   ```
   https://github.com/TPM-Development-Team/codequest-hackathon-platform
   ```

2. Klik tombol **"Fork"** di pojok kanan atas

3. Pilih akun GitHub pribadi Anda sebagai destination

4. Klik **"Create fork"**

5. Fork Anda akan tersedia di:
   ```
   https://github.com/<username-anda>/codequest-hackathon-platform
   ```

### Step 2: Update Git Remote Configuration

Sekarang kita perlu mengkonfigurasi local repository Anda untuk bekerja dengan 2 remote:

```bash
# Masuk ke directory project
cd /Users/rafkiyuda/Documents/Source/codequest-hackathon-platform

# Rename remote 'origin' menjadi 'upstream' (repo team)
git remote rename origin upstream

# Tambahkan fork Anda sebagai 'origin' baru
# GANTI <username-anda> dengan username GitHub Anda
git remote add origin https://github.com/<username-anda>/codequest-hackathon-platform.git

# Verifikasi konfigurasi
git remote -v
```

**Output yang diharapkan:**
```
origin    https://github.com/<username-anda>/codequest-hackathon-platform.git (fetch)
origin    https://github.com/<username-anda>/codequest-hackathon-platform.git (push)
upstream  https://github.com/TPM-Development-Team/codequest-hackathon-platform (fetch)
upstream  https://github.com/TPM-Development-Team/codequest-hackathon-platform (push)
```

### Step 3: Push ke Fork Anda

```bash
# Push branch main ke fork Anda
git push -u origin main

# Push semua branch lainnya jika diperlukan
git push origin --all
```

---

## 🔄 Workflow Sync dengan Upstream

### Menarik Perubahan dari Team Repo (Upstream)

Setiap kali team melakukan update di repository utama, jalankan:

```bash
# 1. Fetch perubahan terbaru dari upstream
git fetch upstream

# 2. Pastikan Anda di branch main
git checkout main

# 3. Merge perubahan dari upstream/main
git merge upstream/main

# 4. Push update ke fork Anda (ini akan trigger Vercel deployment)
git push origin main
```

**Shortcut command** (bisa dijalankan sekaligus):
```bash
git fetch upstream && git checkout main && git merge upstream/main && git push origin main
```

### Push Perubahan Anda Sendiri

Ketika Anda membuat perubahan sendiri:

```bash
# 1. Add dan commit perubahan
git add .
git commit -m "Deskripsi perubahan Anda"

# 2. Push ke fork Anda (trigger Vercel deployment)
git push origin main
```

### Berkontribusi Kembali ke Team Repo (Optional)

Jika Anda ingin kontribusi perubahan ke repository team:

1. Push perubahan ke fork Anda terlebih dahulu
2. Buka fork Anda di GitHub
3. Klik **"Contribute"** → **"Open pull request"**
4. Isi deskripsi PR dan submit

---

## ☁️ Setup Vercel Deployment

### Step 1: Connect Vercel ke GitHub

1. Buka [vercel.com](https://vercel.com)
2. Klik **"Sign Up"** atau **"Log In"**
3. Pilih **"Continue with GitHub"**
4. Authorize Vercel untuk akses GitHub Anda

### Step 2: Import Project

1. Di Vercel dashboard, klik **"Add New..."** → **"Project"**

2. Cari dan pilih repository fork Anda:
   ```
   <username-anda>/codequest-hackathon-platform
   ```

3. Klik **"Import"**

### Step 3: Configure Project Settings

Vercel akan auto-detect konfigurasi, tapi pastikan settingnya seperti ini:

| Setting | Value |
|---------|-------|
| **Framework Preset** | Astro |
| **Root Directory** | `frontend` |
| **Build Command** | `npm run build` |
| **Output Directory** | `dist` |
| **Install Command** | `npm install` |

> **Note:** File `frontend/vercel.json` sudah dikonfigurasi dengan benar, jadi Vercel akan auto-detect settingnya.

### Step 4: Deploy

1. Klik **"Deploy"**
2. Tunggu proses build selesai (biasanya 1-3 menit)
3. Setelah selesai, Anda akan mendapat URL deployment seperti:
   ```
   https://codequest-hackathon-platform-<random>.vercel.app
   ```

### Step 5: Configure Custom Domain (Optional)

Jika Anda punya domain sendiri:

1. Di Vercel project settings, pilih **"Domains"**
2. Tambahkan domain Anda
3. Ikuti instruksi DNS configuration dari Vercel

---

## 🔁 Automatic Deployments

Setelah setup, setiap kali Anda push ke fork Anda, Vercel akan otomatis:
- ✅ Build project
- ✅ Run tests (jika ada)
- ✅ Deploy ke production (jika build sukses)
- ✅ Generate preview URL untuk setiap commit

**Branch deployments:**
- `main` branch → Production deployment
- Branch lain → Preview deployment

---

## 🛠️ Troubleshooting

### Build Gagal di Vercel

**Cek build logs:**
1. Buka deployment yang gagal di Vercel
2. Klik tab **"Build Logs"**
3. Cari error message

**Common issues:**
- **Missing dependencies:** Pastikan `package.json` sudah lengkap
- **Build command error:** Coba run `npm run build` di local dulu
- **Environment variables:** Tambahkan di Vercel project settings jika diperlukan

### Conflict saat Merge Upstream

Jika ada conflict saat merge dari upstream:

```bash
# 1. Lihat file yang conflict
git status

# 2. Edit file yang conflict secara manual
# Cari marker: <<<<<<< HEAD, =======, >>>>>>> upstream/main

# 3. Setelah resolve, add dan commit
git add .
git commit -m "Resolve merge conflict"

# 4. Push ke fork
git push origin main
```

### Fork Tidak Sync dengan Upstream

Jika fork Anda ketinggalan jauh dari upstream:

```bash
# Reset fork Anda ke state upstream (HATI-HATI: ini akan hapus perubahan lokal)
git fetch upstream
git checkout main
git reset --hard upstream/main
git push origin main --force
```

---

## 📝 Quick Reference Commands

**Sync dari upstream:**
```bash
git fetch upstream && git merge upstream/main && git push origin main
```

**Push perubahan Anda:**
```bash
git add . && git commit -m "Your message" && git push origin main
```

**Cek status remote:**
```bash
git remote -v
```

**Cek branch:**
```bash
git branch -a
```

---

## 🎯 Best Practices

1. **Selalu sync sebelum mulai kerja:**
   ```bash
   git fetch upstream && git merge upstream/main
   ```

2. **Commit dengan pesan yang jelas:**
   ```bash
   git commit -m "feat: add new feature X"
   git commit -m "fix: resolve bug in component Y"
   ```

3. **Test di local sebelum push:**
   ```bash
   npm run dev    # Test development
   npm run build  # Test production build
   ```

4. **Review Vercel preview deployment** sebelum merge ke main

---

## 📞 Support

Jika ada masalah:
- **Vercel Docs:** https://vercel.com/docs
- **Astro Docs:** https://docs.astro.build
- **Git Docs:** https://git-scm.com/doc

---

**Happy Deploying! 🚀**
