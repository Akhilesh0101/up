import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CreateHealthTipDTO, ReadHealthTipDTO, UpdateHealthTipDTO } from '../models/health-tips-dto.Model';

@Injectable({
  providedIn: 'root'
})
export class HealthTipsService {
  private apiUrl = 'https://localhost:44348/api/HealthTips';  // Replace with your actual backend URL

  constructor(private http: HttpClient) { }

  // Get all health tips
  getHealthTips(): Observable<ReadHealthTipDTO[]> {
    return this.http.get<ReadHealthTipDTO[]>(this.apiUrl);
  }

  // Get a specific health tip by ID
  getHealthTip(id: number): Observable<ReadHealthTipDTO> {
    return this.http.get<ReadHealthTipDTO>(`${this.apiUrl}/${id}`);
  }

  // Add a new health tip (including image handling)
  addHealthTip(healthTip: CreateHealthTipDTO, file?: File): Observable<ReadHealthTipDTO> {
    const formData = new FormData();
    formData.append('TipTitle', healthTip.TipTitle);
    if (healthTip.TipDescription) formData.append('TipDescription', healthTip.TipDescription);
    formData.append('CategoryId', healthTip.CategoryId.toString());
    
    if (file) {
      formData.append('HealthTipsimg', file, file.name);
    }

    return this.http.post<ReadHealthTipDTO>(this.apiUrl, formData);
  }

  // Update an existing health tip (including image handling)
  updateHealthTip(id: number, healthTip: UpdateHealthTipDTO, file?: File): Observable<ReadHealthTipDTO> {
    const formData = new FormData();
    formData.append('TipTitle', healthTip.TipTitle);
    if (healthTip.TipDescription) formData.append('TipDescription', healthTip.TipDescription);
    formData.append('CategoryId', healthTip.CategoryId.toString());
    
    if (file) {
      formData.append('HealthTipsimg', file, file.name);
    }

    return this.http.put<ReadHealthTipDTO>(`${this.apiUrl}/${id}`, formData);
  }

  // Delete a health tip
  deleteHealthTip(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }
}
